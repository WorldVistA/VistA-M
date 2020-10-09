RAIPS169 ;HISC/GJC RA5_0P169 post-install ; May 08, 2020@11:27:52
 ;;5.0;Radiology/Nuclear Medicine;**169**;Mar 16, 1998;Build 2
 ;
 ;IA          Type    File         Routine     Tag
 ;------------------------------------------------
 ;2053        (S)                  DIE         WP
 ;
EN ;update DESCRIPTION (#4) field for ^DIC(75.1,
 ;
 ;First parameter: File 1: File of Files (FoF)
 ;Second Parameter: IEN of RAD/NUC MED ORDERS file (#75.1)
 ;Third parameter: word-processing (WP) field updated in FoF #4 DESCRIPTION
 ;                 ^DD(1,"B","DESCRIPTION",4)=""
 ;                 ^DD(1,4,0)="DESCRIPTION^1.001^^%D;0"
 ;fourth parameter:
 ;'A' - Append new word-processing (WP) text to the current word-processing data.
 ;      If this flag is not sent, the current contents of the WORD-PROCESSING
 ;      field are completely erased before the new word-processing data is filed.
 ;'K' - LocK the entry or subentry before changing the word-processing data.
 ;
 ;fifth parameter: data_root (the global where the WP data is.
 ;
 ;
 ;D APEND ;leave existing description and append to it 
 K ^TMP($J,"RA751")
 D UPDATE ;kill existing description update to the new description
 ;delete existing WP test from the DESCRIPTION (fld: 4; node: %D)  
 D WP^DIE(1,"75.1,",4,"","^TMP($J,""RA751"")")
 ;the DESCRIPTION field has been update 
 K ^TMP($J,"RA751")
 Q
 ;
UPDATE ;original text
 S ^TMP($J,"RA751",1,0)="This file contains all information pertaining to an imaging order entered" S ^TMP($J,"RA751",2,0)="for a patient. The file structure is like that of the Rad/Nuc Med Patient"
 S ^TMP($J,"RA751",3,0)="file. This imaging order file allows the storage of General Radiology,"
 S ^TMP($J,"RA751",4,0)="Nuclear Medicine, Magnetic Resonance Imaging, Computed Tomography,"
 S ^TMP($J,"RA751",5,0)="Ultrasound and other types of imaging modality data."
 S ^TMP($J,"RA751",6,0)=" "
 S ^TMP($J,"RA751",7,0)=" "
 S ^TMP($J,"RA751",8,0)=" "
 S ^TMP($J,"RA751",9,0)="Data Storage"
 S ^TMP($J,"RA751",10,0)="------------"
 S ^TMP($J,"RA751",11,0)="The data for 'RAD/NUC MED ORDERS' file is stored in the ^RAO(75.1,global.."
 S ^TMP($J,"RA751",12,0)="This file is very volatile and should be journaled and translated if the"
 S ^TMP($J,"RA751",13,0)="operating system supports these two functions."
 S ^TMP($J,"RA751",14,0)=" "
 S ^TMP($J,"RA751",15,0)=" "
 S ^TMP($J,"RA751",16,0)=" "
 S ^TMP($J,"RA751",17,0)="Input Templates"
 S ^TMP($J,"RA751",18,0)="---------------"
 S ^TMP($J,"RA751",19,0)="The following is a list of input templates used by the package"
 S ^TMP($J,"RA751",20,0)="and in the OPTIONS file (#19) that uses the template:"
 S ^TMP($J,"RA751",21,0)=" "
 S ^TMP($J,"RA751",22,0)=" "
 S ^TMP($J,"RA751",23,0)="Input Template Name     Input Template Description     Option(s)"
 S ^TMP($J,"RA751",24,0)="-------------------     --------------------------     ---------"
 S ^TMP($J,"RA751",25,0)="RA ORDER EXAM           Enter an order for a VistA     RAORDER EXAM "
 S ^TMP($J,"RA751",26,0)="                        Radiology procedure."
 S ^TMP($J,"RA751",27,0)=" "
 S ^TMP($J,"RA751",28,0)="RA QUICK EXAM ORDER     Allows quick entry of one or   RAQUICK EXAM ORDER"
 S ^TMP($J,"RA751",29,0)="                        multiple exams for a patient."
 S ^TMP($J,"RA751",30,0)=" "
 S ^TMP($J,"RA751",31,0)="RA OERR EDIT            Edit an unreleased order that"
 S ^TMP($J,"RA751",32,0)="                        was entered through the OE/RR package."
 S ^TMP($J,"RA751",33,0)=" "
 S ^TMP($J,"RA751",34,0)=" "
 S ^TMP($J,"RA751",35,0)=" "
 S ^TMP($J,"RA751",36,0)="Print Templates"
 S ^TMP($J,"RA751",37,0)="---------------"
 S ^TMP($J,"RA751",38,0)="There are no print templates associated with this file."
 S ^TMP($J,"RA751",39,0)=" "
 S ^TMP($J,"RA751",40,0)=" "
 S ^TMP($J,"RA751",41,0)=" "
 S ^TMP($J,"RA751",42,0)="Sort Templates"
 S ^TMP($J,"RA751",43,0)="--------------"
 S ^TMP($J,"RA751",44,0)="There are no sort templates associated with this file."
 Q
 ;
