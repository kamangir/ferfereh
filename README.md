# 🌀 ferfereh

🌀 `ferfereh` is a 3d-printed piece of graffiti with a cloud-generated [map](./coords.geojson).

```bash
pip install blue-plugin
```

```bash
 > ferfereh help
ferfereh cleanup
 . cleanup ferfereh.
ferfereh exif get \
	[-] \
	<filename.jpg>
 . get exif.
ferfereh exif install
 . install exif.
ferfereh exif put \
	[~backup,dryrun,lat=<lat>,lon=<lon>,validate] \
	<filename.jpg>
 . put exif.
ferfereh publish coords \
	[~downloads]
 . publish ferfereh coords.
ferfereh publish 3d-files
 . publish ferfereh 3d-files.
```

| [![image](./images/gen5.jpg)](#gen5) | [![image](./images/gen6-c2.jpg)](#gen6) | [![image](./images/gen6-s.jpg)](#gen6) | [![image](./images/gen7-2.jpg)](#gen7) |
| ------------------------------------ | --------------------------------------- | -------------------------------------- | -------------------------------------- |

# brackets

## gen5

![image](./images/gen5.png)

- [gen5.stl](./3d/gen5.stl)

## gen6

![image](./images/gen6.png)

- [gen6-c4](./3d/gen6-c4.stl)
- [gen6-d32](./3d/gen6-d32.stl)
- [gen6-s4](./3d/gen6-s4.stl)

## gen7

![image](./images/gen7.png)

- [gen7-2](./3d/gen7-2.stl)

# tools & materials

| item                                                                      | image                                                           | examples                                                                           |
| ------------------------------------------------------------------------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| 2 mm solid brass rods                                                     | ![image](./images/tools/solid-brass-bars.jpeg)                  | https://www.amazon.ca/gp/product/B089LDXN22                                        |
| aviation snips                                                            | ![image](./images/tools/aviation-snips.jpeg)                    |                                                                                    |
| (multiple) bags to carry the brackets, tools, and other materials to site | ![image](./images/tools/bags.jpeg)                              |                                                                                    |
| cutting nippers                                                           | ![image](./images/tools/cutting-nippers.jpeg)                   |                                                                                    |
| mini pliers                                                               | ![image](./images/tools/mini-pliers.jpeg)                       |                                                                                    |
| propeller fan                                                             | ![image](./images/tools/propellers.jpeg)                        | https://www.adafruit.com/product/3896, https://www.amazon.ca/gp/product/B091TBQ7CK |
| double-sided, outdoor, water-resistant, mounting tape                     | ![image](./images/tools/mounting-tape.jpeg)                     |                                                                                    |
| multi bit electronics screwdriver                                         | ![image](./images/tools/multi-bit-electronics-screwdriver.jpeg) |                                                                                    |
| precision craft knife w/ spare blade                                      | ![image](./images/tools/precision-craft-knife.jpeg)             |                                                                                    |
| small hammer                                                              | ![image](./images/tools/small-hammer.jpeg)                      |                                                                                    |
| M3 Nylon Machine Screws                                                   | ![image](./images/tools/screws.jpg)                             | https://www.amazon.ca/gp/product/B012TACIBC                                        |

---

[![PyPI version](https://img.shields.io/pypi/v/ferfereh.svg)](https://pypi.org/project/ferfereh/)
