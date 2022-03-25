# temp with chains

# before

if (platform.upcase.index("MAC") &&
    browser.upcase.index("IE") &&
    initialized? &&
    resize > 0
    )
  # do something

end


# after

  is_mac_os = platform.upcase.index("MAC")
  is_ie_browser = browser.upcase.index("IE")
  was_resized = resize > 0

  if (is_mac_os && is_ie_browser && was_resized && initialized?)
    # do something
  end


# before



# after
















