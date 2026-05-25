PRCA447P ;MNTVBB/KXL - Disable AR CBO Extract ;04/14/25
 ;;4.5;Accounts Receivable;**447**;Mar 20, 1995;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to FIND1^DIC in ICR #2051
 ; Reference to FILE^DIE in ICR #10018
 ; Reference to ^DIK in ICR #10013
 ; Reference to FMADD^XLFDT in ICR #10103
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to MES^XPDUTL in ICR #10141
 ; Reference to LKOPT^XPDMENU in ICR #1157
 ; Reference to OUT^XPDMENU in ICR #1157
 ; 
 ;
 Q
 ;
EN ; Backup files
 ;
 ;AR DATA QUEUE file ^RCXV (#348.4)
 ;ACCOUNTS RECEIVABLE TRANS.TYPE FILE ^PRCA (#430.3)
 ;
 N P447FILE,P447FILES,PRCAA,PRCACNT
 S P447FILE=""
 S P447FILES="348.4^430.3"
 S PRCACNT=0
 F PRCACNT=1:1:$L(P447FILES,"^") D
 . S P447FILE=$P(P447FILES,"^",PRCACNT)
 . D GLBBKUP
 . Q
 ; Begin Update
 D POST
 Q
 ;
POST ; Disable CBO extract and associated objects
 N U S U="^"
 D MSG("PRCA*4.5*447 Post-Install starts.....")
 D ARPAR
 D MENU
 D QUEUE
 D TRANSTYP
 D TSK
 D MSG(" ")
 D MSG("PRCA*4.5*447 Post-Install is complete.")
 Q
 ;
ARPAR ; Set CBO STATUS = 0 in AR Site Param file (#342)
 ;
 N PRCAUP
 S PRCAUP(342,"1,",20.04)=0
 D FILE^DIE("E","PRCAUP","ERROR")
 D BMES^XPDUTL("FILE 342 CBO STATUS set to OFF")
 Q
 ;
QUEUE ; Purge AR Data Queue
 ;AR DATA QUEUE file (#348.4)
 N DA,DIK
 S DIK="^RCXV("
 S DA=0
 F  S DA=$O(^RCXV(DA)) Q:DA=""!(DA?.A)  D
 . D ^DIK
 D BMES^XPDUTL("AR Data Queue File (#348.4) purge completed")
 Q
 ;
TRANSTYP ; Set CBO flag = 0 if currently set = 1
 ;ACCOUNTS RECEIVABLE TRANS.TYPE FILE (#430.3)
 N PRCACBO,PRCAIEN,PRCAND
 S PRCAIEN=0
 F  S PRCAIEN=$O(^PRCA(430.3,PRCAIEN)) Q:PRCAIEN=""!(PRCAIEN?.A)  D
 . S PRCAND=^PRCA(430.3,PRCAIEN,0)
 . S PRCACBO=$P(PRCAND,U,6)
 . I PRCACBO=1 S PRCAUP(430.3,PRCAIEN_",",5)=0
 D FILE^DIE("I","PRCAUP","PRCAERR")
 D BMES^XPDUTL("ACCOUNTS RECEIVABLE TRANS.TYPE FILE (#430.3) updated")
 Q
 ;
TSK ; Remove task from OPTION SCHEDULING file (#19.2)
 N DA,DIK
 D BMES^XPDUTL("Checking if List of NPI data for CBO is tasked")
 S DA=$$FIND1^DIC(19.2,"","","XUS NPI CBO LIST") I DA>0 D  Q
 . S ^XTMP("PRCA447P",$J,0)=$$FMADD^XLFDT(DT+90)_"^"_DT_"^copy of CBO Task^"_DA
 . M ^XTMP("PRCA447P",19.2,$H,DA)=^DIC(19.2,DA)
 . S DIK="^DIC(19.2," D ^DIK
 . D BMES^XPDUTL("Task removed")
 D BMES^XPDUTL("Not tasked, no action needed")
 Q
 ;
MSG(PRCAA) ;
 D MES^XPDUTL(PRCAA)
 Q
 ;
GLBBKUP  ; XTMP Backup of file(s)
 N PRCABKND
 S PRCABKND="PRCA*4.5*477-Disable CBO file updates (#348.4,430.3)"
 S ^XTMP("PRCA447P",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_PRCABKND
 I P447FILE=348.4 M ^XTMP("PRCA447P",P447FILE,$H)=^RCXV Q
 M ^XTMP("PRCA447P",P447FILE,$H)=^PRCA(P447FILE)
 Q
 ;
MENU ; Make CBO menu options out of order
 ;
 N PRCAI,PRCAM,PRCAO
 S PRCAO="Option placed out of order with patch PRCA*4.5*447"
 F PRCAI=1:1 S PRCAM=$P($T(OPTS+PRCAI),";;",2) Q:PRCAM=""  D
 .N PRCAY S PRCAY=$$FIND1(PRCAM) I PRCAY<0 D BMES^XPDUTL("Option: "_PRCAM_" was not found!") Q
 .D OUT^XPDMENU(PRCAM,PRCAO)
 .D BMES^XPDUTL("Option: "_PRCAM_" placed out of order")
 .Q
 Q
 ;
FIND1(PRCAX) ;find the option IEN based on the option name
 ;Input: PRCAX = option name
 ;Return: IEN option name; else -1
 N PRCAERR,Y
 S Y=$$LKOPT^XPDMENU(PRCAX)
 Q $S(Y="":-1,1:Y)
 ;
OPTS ;menu options to make out of order
 ;;PRCA CBO PARAMETERS
 ;;RCXVSRV
