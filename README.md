# TagRAW
Tag RAW files that have the same file names as the tagged JPG files in another folder.
1. Have all of your raw files in "RAW" folder, have all of your jpg files in "JPG" folder. Put both "RAW" and "JPG" in the same parent folder, say, "Photos"
2. Assume you have already tagged some of the files in "JPG" folder with Yellow tag. Say "photo1.JPG", "photo8.JPG" are tagged Yellow.
3. Navigate to "Photos"
4. Copy the file "tag.sh" to "Photos"
5. Start a Terminal window in "Photos"
6. Run **chmod -x tag.sh**
7. Run **./tag.sh 'JPG/1' 'RAW/1'**
8. Navigate to "RAW" folder. You should see "photo1.CR3" and "photo8".CR3 taggeed Red now.
