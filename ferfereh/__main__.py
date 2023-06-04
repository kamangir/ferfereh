import argparse
from ferfereh import NAME, VERSION
from ferfereh.utils import cleanup
from ferfereh.coords import publish_coords
from abcli import logging
import logging

logger = logging.getLogger(__name__)

parser = argparse.ArgumentParser(NAME, description=f"{NAME}-{VERSION}")
parser.add_argument(
    "task",
    type=str,
    help="cleanup|publish_coords|version",
)
parser.add_argument(
    "--output_filename",
    type=str,
)
parser.add_argument(
    "--path",
    type=str,
)
args = parser.parse_args()

success = False
if args.task == "cleanup":
    success = cleanup(args.path)
elif args.task == "publish_coords":
    success = publish_coords(args.output_filename)
elif args.task == "version":
    print(f"{NAME}-{VERSION}")
    success = True
else:
    logger.error(f"-{NAME}: {args.task}: command not found.")

if not success:
    logger.error(f"-{NAME}: {args.task}: failed.")
