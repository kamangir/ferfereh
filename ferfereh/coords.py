import os
from exif import Image
from shapely import geometry
import geopandas as gpd
from tqdm import tqdm
from abcli import file
from abcli.modules import objects
from abcli.logging import crash_report
import abcli.logging
import logging

logger = logging.getLogger()

# https://medium.com/spatial-data-science/how-to-extract-gps-coordinates-from-images-in-python-e66e542af354
def decimal_coords(coords, ref):
    decimal_degrees = coords[0] + coords[1] / 60 + coords[2] / 3600
    if ref == "S" or ref == "W":
        decimal_degrees = -decimal_degrees
    return decimal_degrees


def get_image_info(image_path):
    with open(image_path, "rb") as src:
        img = Image(src)
    if not img.has_exif:
        logger.info(f"{file.name_and_extension(image_path)}: no EXIF information.")
        return False, {}

    try:
        img.gps_longitude
        coords = (
            decimal_coords(img.gps_latitude, img.gps_latitude_ref),
            decimal_coords(img.gps_longitude, img.gps_longitude_ref),
        )
    except AttributeError:
        crash_report(f"{file.name_and_extension(image_path)}: bad EXIF information.")
        return False, {}

    return True, {
        "datetime": img.datetime_original,
        "coords": coords,
    }


def publish_coords(output_filename):
    object_id = os.getenv("FERFEREH_IMAGE_OBJECT")
    if not object_id:
        logger.info(f"FERFEREH_IMAGE_OBJECT not found, quitting.")
        return False

    list_of_images = [
        filename
        for filename in objects.list_of_files(object_id)
        if file.extension(filename) in ["jpg"]
    ]
    logger.info(f"{len(list_of_images)} image(s) found.")

    coords = []
    metadata = {keyword: [] for keyword in "datetime,filename".split(",")}
    fail_count = 0
    for filename in tqdm(list_of_images):
        success_, info = get_image_info(filename)
        if not success_:
            fail_count += 1
            continue

        coords += [
            geometry.Point(
                info["coords"][1],
                info["coords"][0],
            )
        ]
        metadata["filename"] += [file.name_and_extension(filename)]
        metadata["datetime"] += [info["datetime"]]

    if fail_count:
        logger.info(f"{fail_count} failure(s).")

    gdf = gpd.GeoDataFrame(metadata, geometry=coords)
    gdf.crs = "EPSG:4326"
    gdf.to_file(output_filename)
    logger.info(f"->{output_filename}")

    return True
