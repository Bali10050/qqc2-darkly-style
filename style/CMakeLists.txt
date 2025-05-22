add_subdirectory(impl)
add_subdirectory(qtquickcontrols)

if(ANDROID)
    install(FILES DarklyLight.colors DarklyDark.colors DESTINATION ${KDE_INSTALL_DATADIR}/color-schemes)
endif()
