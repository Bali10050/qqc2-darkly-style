# QQC2 Darkly Style

- [x] Rename
- [ ] Make it look like darkly
    - [ ] Buttons
    - [ ] Sliders
    - [ ] Checkboxes
    - [ ] Radio
    - [ ] Lineedit

## Usage

Using the `QT_QUICK_CONTROLS_STYLE=org.kde.darkly` environment variable

## Building

```
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF ..
make -j $(nproc)
sudo make install
```
