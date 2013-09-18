<?
// Create the mysql backup file
// edit this section
$dbhost = "uselolli.db.10981442.hostedresource.com"; // usually localhost
$dbuser = "uselolli";   //enter your database username
$dbpass = 'Divert0205!'; //enter your database password
$dbname = "uselolli";  //enter your database name
$dropbox_email='marques@gmail.com';  //Dropbox username
$dropbox_pass='poslla';   // Dropbox password
$dropbox_dir=''; //DropBox directory (optional) - Folder on the Dropbox 

// don't need to edit below this section

$backupfile = $dbname . date("Y-m-d") . '.sql.gz';
$backupdir = dirname(__FILE__);
system("mysqldump -h $dbhost -u $dbuser --password='$dbpass' $dbname | gzip > $backupfile");

include('DropboxUploader.php');
$uploader = new DropboxUploader($dropbox_email, $dropbox_pass);
$uploader->upload($backupdir.'/'.$backupfile,$dropbox_dir);
unlink($backupfile);


?>
