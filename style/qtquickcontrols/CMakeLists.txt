ecm_add_qml_module(DarklyStyle URI "org.kde.darkly"
    GENERATE_PLUGIN_SOURCE
    DESIGNER_SUPPORTED
    DEPENDENCIES
    "QtQuick.Controls"
    "QtQuick.Window"
    "org.kde.kirigami"
    "org.kde.darkly.impl"
    "org.kde.guiaddons"
)

ecm_target_qml_sources(DarklyStyle SOURCES
    AbstractButton.qml
    ApplicationWindow.qml
    BusyIndicator.qml
    Button.qml
    ButtonGroup.qml
    CheckBox.qml
    CheckDelegate.qml
    ComboBox.qml
    Container.qml
    Control.qml
    DelayButton.qml
    Dial.qml
    Dialog.qml
    DialogButtonBox.qml
    Drawer.qml
    Frame.qml
    GroupBox.qml
    HorizontalHeaderView.qml
    ItemDelegate.qml
    Label.qml
    Menu.qml
    MenuBar.qml
    MenuBarItem.qml
    MenuItem.qml
    MenuSeparator.qml
    MobileTextActionsToolBar.qml
    Page.qml
    PageIndicator.qml
    Pane.qml
    Popup.qml
    ProgressBar.qml
    RadioButton.qml
    RadioDelegate.qml
    RangeSlider.qml
    RoundButton.qml
    ScrollBar.qml
    ScrollIndicator.qml
    ScrollView.qml
    Slider.qml
    SpinBox.qml
    SplitView.qml
    StackView.qml
    SwipeDelegate.qml
    SwipeView.qml
    Switch.qml
    SwitchDelegate.qml
    TabBar.qml
    TabButton.qml
    TextArea.qml
    TextField.qml
    ToolBar.qml
    ToolButton.qml
    ToolSeparator.qml
    ToolTip.qml
    Tumbler.qml
    VerticalHeaderView.qml
)

if (NOT BUILD_SHARED_LIBS)
    target_link_libraries(DarklyStyle PRIVATE org.kde.darkly)
endif()

ecm_finalize_qml_module(DarklyStyle EXPORT QQC2DarklyStyleTargets)
