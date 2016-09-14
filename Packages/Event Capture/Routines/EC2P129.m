EC2P129 ;ALB/JAM - Post install routine for Event Capture patch EC*2*129 ;7/13/2014
 ;;2.0;EVENT CAPTURE;**129**;8 May 96;Build 7
 ;
 Q
EN ;This post install routine will remove obsolete *EVENT CAPTURE PROCEDURE, ^ECP(, File #720
 ; and *EVENT CODE SCREENING, ^ECK(, #720.2 and their data from the system. Sort template
 ; ECCAT linked to File #720 will also be removed.
 ; Patch EC*2*5 flagged the 2 files for deletion by a future patch. This patch will delete these files.
 ;
 D BMES^XPDUTL("Removing Files #720 and #720.2 with data and templates from the system.")
 D BMES^XPDUTL("These files were flagged for deletion by EC*2*5 and is now being removed.")
 D MES^XPDUTL("Please be patient while the files are being removed.")
 N DIU
 S DIU(0)="DT"
 F DIU=720,720.2 D EN^DIU2
 D BMES^XPDUTL("Done!")
 Q
 ;
