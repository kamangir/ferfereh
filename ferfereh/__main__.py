import argparse
from ferfereh import NAME, VERSION, DESCRIPTION
from ferfereh.logger import logger
from blueness.argparse.generic import ending


parser = argparse.ArgumentParser(NAME, description=f"{NAME}-{VERSION}")
parser.add_argument(
    "task",
    type=str,
    help="cleanup|description|publish_coords|version",
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
    from ferfereh.utils import cleanup

    success = cleanup(args.path)
elif args.task == "description":
    print(DESCRIPTION)
    success = True
elif args.task == "publish_coords":
    from ferfereh.coords import publish_coords

    success = publish_coords(args.output_filename)
elif args.task == "version":
    print(f"{NAME}-{VERSION}")
    success = True
else:
    success = None

ending(logger, NAME, args.task, success)
