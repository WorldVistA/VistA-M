DVBA2848 ;BP/MM - Pre/Post init for DVBA*2.7*148 ; 09/09/2009
 ;;2.7;AMIE;**148**;Apr 10, 1995;Build 11
 ;
 ; This routine adds menu items to the menus distributed in DVBA*2.7*84.
 ; The menu changes were requested by HRC.
 ;
PRE ;
 ;
 ;Delete TEST VERSION options from menus.
 ;
 N DVBE,DVBF
 S DVBE=$$LKOPT^XPDMENU("DVBA HRC MENU EXTENDED SVCS")
 S DVBF=$$LKOPT^XPDMENU("PRCA BILL STATUS LISTING")
 I ($G(DVBE)]"")&($G(DVBF)]"") D 
 . I $D(^DIC(19,DVBE,10,"B",DVBF)) D DELMENU("DVBA HRC MENU EXTENDED SVCS","PRCA BILL STATUS LISTING")
 ;
 N DVBG,DVBH
 S DVBG=$$LKOPT^XPDMENU("DVBA HRC MENU PHARMACY CC")
 S DVBH=$$LKOPT^XPDMENU("PSO LM BACKDOOR ORDERS")
 I ($G(DVBG)]"")&($G(DVBH)]"") D 
 . I $D(^DIC(19,DVBG,10,"B",DVBH)) D DELMENU("DVBA HRC MENU PHARMACY CC","PSO LM BACKDOOR ORDERS")
 ;
 Q
POST ;
 ;
 ;See ADDMNU for documentation on input parameters.
 ;Last parameter is the Display Order.  Must be a number from 1 - 99.
 ;
 ;Pharmacy menu
 ;
 D BMES^XPDUTL("-> Adding options to HRC Pharmacy Customer Care Menu <-")
 D ADDMNU("DVBA HRC MENU PHARMACY CC","DVBA HRC MENU","HRC",5)
 D ADDMNU("DVBA HRC MENU PHARMACY CC","PSO P","MP",15)
 D ADDMNU("DVBA HRC MENU PHARMACY CC","PSO VIEW","VW",20)
 D ADDMNU("DVBA HRC MENU PHARMACY CC","OR MAIN MENU WARD CLERK","WC",25)
 ;
 D BMES^XPDUTL("-> Adding options to HRC Pharmacy Menu <-")
 D ADDMNU("DVBA HRC MENU PHARMACY","PSO LM BACKDOOR ORDERS","PP",7)
 D ADDMNU("DVBA HRC MENU PHARMACY","OR MAIN MENU WARD CLERK","WC",20)
 ;
 ; Main menu
 ;
 D BMES^XPDUTL("-> Adding options to HRC First Party CC Menu <-")
 D ADDMNU("DVBA HRC MENU","PSO P","MP",48)
 D ADDMNU("DVBA HRC MENU","PSO VIEW","VW",49)
 D ADDMNU("DVBA HRC MENU","IB ECME BILLING EVENTS","ECME",25)
 ;
 ;Extended Services menu
 ;
 D BMES^XPDUTL("-> Adding options to HRC First Party Extended Services Menu <-")
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","DVBA HRC MENU","HRC",5)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","DGFFP FUGITIVE FELON PROGRAM","FUG",10)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","IB RX HARDSHIP","MAN",20)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCA BIL AGENCY","GP",22)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCA NOTIFICATION PARAMETERS","ST",25)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCA RCDMC LESSER WITHHOLDING","ENT",30)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCAC COWC REFER","CO",35)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCAC TR RE-ESTABLISH BILL","RE",40)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCAF ADJ ADMIN","ADM",45)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCAF U ADMIN.RATE","INT",48)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","RCBD TRANSACTION STMT HISTORY","TSH",50)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","RCDP RECEIPT PROCESSING","RP",55)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","RCDP SUMMARY 215 REPORT","SUM",60)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","RCDPE EDI LOCKBOX MENU","EDI",65)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCAC TR SUSPENDED","SUS",70)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCA DEBTOR COMMENT","DB",75)
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","RCDP LIST OF RECEIPTS REPORT","LIST",85)
 ;
 Q
ADDMNU(DVB1,DVB2,DVB3,DVB4) ;
 ;
 ;Adds Items to Menu (#19.01) subfile in Option (#19) file
 ;Input:  
 ;     DVB1 = Name of the menu(Required)
 ;     DVB2 = Item (#.01)- Name of Option being added to the menu. (Required)
 ;     DVB3 = Synonym (#2) field (optional)
 ;     DVB4 = Display Order (#3) field (optional) (Number from 1 - 99)
 ;
 ;Output: 1 = Success - Option added to menu.
 ;        0 = Failure - Option not added to menu.
 ;
 N DVOK
 S DVOK=$$ADD^XPDMENU(DVB1,DVB2,DVB3,DVB4)
 I 'DVOK D  Q
 .D MES^XPDUTL("  Could not add "_DVB2_" to "_DVB1)
 D MES^XPDUTL("  "_DVB2_" added to "_DVB1)
 Q
 ;
DELMENU(DVBD1,DVBD2) ;
 ;
 ;Use:  Remove PRCA BILL STATUS LISTING for Test sites with an earlier verion of this patch
 ;
 ;Deletes Items from Menu (#19.01) in Option (#19) file
 ;Input:
 ;     DVBD1 = Name of the menu (Required) 
 ;     DVBD2 = Item (#.01) - Name of the Option being deleted from the menu. (Required)
 ;
 ;Output: 1 = Success - option deleted from menu
 ;        0 = Option not deleted from menu 
 ;
 N DVOK
 D BMES^XPDUTL("-> Removing "_DVBD2_" option <-")
 D BMES^XPDUTL("   from "_DVBD1_" Menu")
 S DVOK=$$DELETE^XPDMENU(DVBD1,DVBD2)
 I DVOK D  Q
 . D MES^XPDUTL("  Removed "_DVBD2_" from "_DVBD1_" Menu")
 I 'DVOK D  Q
 . D MES^XPDUTL("  Could not remove "_DVBD2_"  from "_DVBD1_" Menu")
 Q
