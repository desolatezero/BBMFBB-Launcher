# BBMFBB Launcher
$scriptVersion = "v0.6"
# peterg@paramountdigitalsecurity.com
# MIT License
# Copyright (c) 2023 Peter Goudswaard

# Base path for all scripts and resources
$scriptBasePath = "C:\Program Files\BBMFBB Launcher"
$logoFileName = "BBMFBB.png"
# Can set window background color to custom color
$bgcolor = "#DDDDDD"
# Can either set button color to custom color
$buttonBgcolor = "#EEEEEE"
$buttonFgcolor = "#000000"

# Load necessary assemblies for creating GUI
Add-Type -AssemblyName System.Windows.Forms

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'YourCompany Script/Utility Menu'
$form.Width = 400
$form.Height = 380
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml($bgcolor)

# Set the form to appear in the center of the screen
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle  # Comment out to enable resizing of form
$form.MaximizeBox = $false  # Disable maximize button

# Add logo using PictureBox
$logo = New-Object System.Windows.Forms.PictureBox
$logo.Image = [System.Drawing.Image]::FromFile("$scriptBasePath\$logoFileName")
$logo.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$logo.Width = 104  # Adjusted for the 2-pixel border on each side
$logo.Height = 104  # Adjusted for the 2-pixel border on each side
$logo.Location = New-Object System.Drawing.Point(146, 8)  # Adjusted to center the logo with the new size

# uncomment the next 2 lines if you want a box around your logo
# $logo.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle  # Set border style
# $logo.Padding = New-Object System.Windows.Forms.Padding(2)  # Set padding to create a 2-pixel border effect

$form.Controls.Add($logo)

# Separator line
$separator = New-Object System.Windows.Forms.Label
$separator.Width = $form.Width - 40  # Adjust width as needed
$separator.Height = 1  # Height of 2 pixels for the line
$separator.BackColor = [System.Drawing.Color]::Black  # Color of the line
$separator.Location = New-Object System.Drawing.Point(10, 122)  # Adjust Y-coordinate based on logo's height and desired spacing
# comment out the next line if you don't want the separator line visible below the logo
$form.Controls.Add($separator)

# Create a label to select the script choice
$label = New-Object System.Windows.Forms.Label
$label.Text = 'Select a script to run:'
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10,140)
$form.Controls.Add($label)

# Define a hashtable that maps friendly names to script filenames
# Do not include the path. The files need to be stored in the same folder as this script, as the
# execute command looks in $scriptBasePath for the Scripts
# Add as many lines as needed for the number of scripts you need
# Hashtables (the list of script names) don't guarantee any sort order. 
# To order the friendly names, number the friendly names, for example "1. do this"
$scriptMap = @{
    'Friendly Name 1' = 'Script1.ps1'
    'Friendly Name 2' = 'Script2.ps1'
    'Friendly Name 3' = 'Script3.ps1'
}

# Create a dropdown (ComboBox) for script selection
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(10,160)
$comboBox.Width = 360

# Sort the hashtable
$sortedKeys = $scriptMap.Keys | Sort-Object

# Add sorted script options to the dropdown
$comboBox.Items.AddRange($sortedKeys)
$form.Controls.Add($comboBox)

# Create a button to run the selected script
$button = New-Object System.Windows.Forms.Button
$button.Text = 'Run Script'
$button.Location = New-Object System.Drawing.Point(10,205)
$button.BackColor = $buttonBgcolor
$button.ForeColor = $buttonFgcolor

# Create label to display error messages
$errorLabel = New-Object System.Windows.Forms.Label
$errorLabel.ForeColor = [System.Drawing.Color]::Red
$errorLabel.AutoSize = $true
$errorLabel.Location = New-Object System.Drawing.Point(10, 185)  # Adjust Y-coordinate based on the button's position and desired spacing
$form.Controls.Add($errorLabel)

# Event handler to clear any error message if combobox is interacted with
$comboBox.Add_SelectedIndexChanged({
    $errorLabel.Text = ""  # Clear the error message
})

$button.Add_Click({
    $selectedFriendlyName = $comboBox.SelectedItem
    if ($selectedFriendlyName) {
        $selectedScript = $scriptMap[$selectedFriendlyName]
        $scriptPath = "$scriptBasePath\$selectedScript"
        if (Test-Path $scriptPath) {
            & $scriptPath
            $errorLabel.Text = ""  # Clear any previous error message
        } else {
            $errorLabel.Text = "Error: Script file not found"
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please select a script from the dropdown.", "Warning", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})

$form.Controls.Add($button)

# Create an Exit button
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Text = 'Exit'
$exitButton.Location = New-Object System.Drawing.Point(10,245)
$exitButton.BackColor = $buttonBgcolor
$exitButton.ForeColor = $buttonFgcolor

$exitButton.Add_Click({
    $form.Close()
})

$form.Controls.Add($exitButton)

# Custom footer text
$customTextLabel = New-Object System.Windows.Forms.Label
$customTextLabel.Text = 'Your Custom Footer Text Here'
$customTextLabel.AutoSize = $false  # Set to false to allow custom dimensions
$customTextLabel.Width = $form.Width
$customTextLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$customTextLabel.Location = New-Object System.Drawing.Point(0, 290)  # Adjust Y-coordinate as needed
$form.Controls.Add($customTextLabel)

# Footer version text label
$footerLabel = New-Object System.Windows.Forms.Label
$footerLabel.Text = 'BBMFBB Launcher ' + $scriptVersion
$footerLabel.AutoSize = $true
$footerLabel.Font = New-Object System.Drawing.Font("Arial", 7)  # Adjust font name and size as needed
$footerLabel.ForeColor = [System.Drawing.Color]::DarkGray  # Adjust color for subtle visibility
$footerLabel.Location = New-Object System.Drawing.Point(10, 330)  # Adjust Y-coordinate to position at the bottom
$form.Controls.Add($footerLabel)

# Display the form
$form.ShowDialog()