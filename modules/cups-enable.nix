# For the time being (until legacy printer drivers are
# retired in CUPS), we can add the Brother HL-2250DN I
# have by navigating to the CUPS WebUI on
#   http://localhost:631/
# Here we can add the printer with:
#   > Administration
#   > Find New Printers
#   > Select Printer
#   > Brother
#   > Brother HL-2250DN - CUPS+Gutenprint v5.3.5 (en)
#   > Add Printer
#   > Set Printer Options
#   > A4
{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.gutenprint];
  };
}
