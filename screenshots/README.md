# Screenshots

## How to Add Screenshots

1. **Run the app** in Xcode:
   ```bash
   open "Dental X.xcodeproj"
   ```

2. **Launch simulator** and run the app (⌘R)

3. **Take screenshots**:
   - In simulator: Press `⌘S` or `Cmd+S`
   - Screenshots are saved to Desktop

4. **Rename and move screenshots** to this folder:
   ```bash
   # Rename files to match README
   mv ~/Desktop/Screenshot*.png screenshots/
   ```

5. **Required screenshots**:
   - `patients_list.png` - Main patients list view
   - `patient_detail.png` - Patient detail screen
   - `add_patient.png` - Add patient form
   - `schedule.png` - Schedule/calendar view
   - `add_appointment.png` - Add appointment form
   - `ai_screen.png` - AI diagnosis screen
   - `settings.png` - Settings screen

6. **Commit and push**:
   ```bash
   git add screenshots/
   git commit -m "Add app screenshots"
   git push
   ```

## Screenshot Guidelines

- **Device**: Use iPhone 16 Pro or iPhone 16 for screenshots
- **Format**: PNG files
- **Size**: Keep original simulator resolution
- **Theme**: Take both Light and Dark mode if needed
- **Content**: Use sample data (already included in app)

## Quick Command

```bash
# After taking screenshots on Desktop
cd "/Users/nurgazyzhangozy/Desktop/IOS DEVELOPER/Dental X"
mv ~/Desktop/Simulator\ Screen\ Shot*.png screenshots/

# Rename them appropriately
# Then commit
git add screenshots/
git commit -m "Add app screenshots"
git push
```

## Example Layout

The screenshots will appear in the main README.md like this:

```
Row 1: patients_list | patient_detail | schedule | ai_screen
Row 2: add_patient | add_appointment | settings
```

All screenshots will be displayed at 200px width for consistency.
