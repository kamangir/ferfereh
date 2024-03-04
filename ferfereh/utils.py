import os
from PIL import Image
from abcli import file
from ferfereh.logger import logger


def cleanup(path):
    logger.info(f"ferfereh.clean({path})")

    for filename in file.list_of(os.path.join(path, "*.jpeg")):
        image = Image.open(filename)

        width, height = image.size
        if width == height:
            continue

        size = max(width, height)
        new_image = Image.new("RGB", (size, size), (0, 0, 0))

        left = (size - width) // 2
        top = (size - height) // 2
        new_image.paste(image, (left, top))

        new_image.save(filename)
        logger.info(f"-> {filename}")

    return True
