from exif import Image
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
        logger.info(f"{image_path}: no EXIF information.")
        return False, {}

    try:
        img.gps_longitude
        coords = (
            decimal_coords(img.gps_latitude, img.gps_latitude_ref),
            decimal_coords(img.gps_longitude, img.gps_longitude_ref),
        )
    except AttributeError:
        crash_report(f"{image_path}: bad EXIF information.")
        return False, {}

    return True, {
        "datetime": img.datetime_original,
        "coords": coords,
    }


def publish_locations():
    ...
    return True
