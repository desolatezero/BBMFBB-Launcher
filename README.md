MMMFBB Launcher
MIT License
Copyright (c) 2023 Peter Goudswaard

INSTALLATION
============

Copy all files to C:\Program Files\BBMFBB Launcher\.

In your Syncro desktop policy, go to System Tray, create a menu type "Execute a CMD", with a title of your choosing, ie "Run Utilities", and the CMD to run is:
powershell.exe -ExecutionPolicy RemoteSigned -file "C:\Program Files\BBMFBB Launcher\bbmfbb.ps1"

If you have Threatlocker installed, you'll need to create AN exception for bbmfbb.ps1, and any other .ps1 scripts that you create.

CUSTOMIZATION
=============

Line numbers are for reference only and may change as code changes. The phrase "comment out" refers to adding a "# " at the beginning of a line, which signifies a comment and not an instruction that the script will perform.

Line 8, $scriptBasePath needs to reflect the correct path that you are running the BBMFBB Launcher as well as the scripts from. Currently, the scripts that the Launcher runs must also reside in the same path.

Line 9, $logoFileName should be the name of your company's logo in most non-animated popular file formats. It will downsize the logo to fit.

Line 11, $bgcolor is the main window background color.
Line 13, $buttonBgcolor is the button background color.
Line 14, $buttonFgcolor is the button foreground color.

Line 21, $form.Text can be changed to your company's name.

Line 28, comment out this line to enable resizing of the form.
Line 29, comment out this line if you want to enable the form maximize button.

Lines 40 & 41, uncomment these to add a 2-pixel border effect around your logo. Edit the number in .Padding(x) to change the width in pixels of the border.

Line 52, comment out $form.Controls.Add($separator) line to eliminate the separator line visible below the logo.

Line 56, You can change the text in the single quotes 'Select a script to run:' to anything you wish.

Lines 68 onward, change the 'Friendly Name x' to a descriptive name that your clients will recognize, and the script name following it to the exact name of the script file that will be executed. The script file must be in the same folder as the Launcher and as specified in the $scriptBasePath. The order of the dropdown will be in alphabetical order not the order in which they are listed, so you may wish to number them inside the single quotes, ie '1. clean print queue'. Add as many or as few as you need.

Line 137, the line that starts with $customTextLabel.Text =. Set your customer footer text on this line. It might be your company's contact information, a disclaimer, or anything relevant you wish. Comment out the line if you do not want a custom footer text.

Line 149, the line that starts with $footerLavel.ForeColor. If you have a custom window color and the Launcher version is no longer visible, adjust this color so that it is.










