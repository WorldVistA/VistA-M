ORY405NV ;ALB/BKG/gsn - POST-INIT ORDER DIALOG UPDATE ;Apr 29, 2022@10:02:04
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405**;Dec 17, 1997;Build 211
 ;This routine will update the Order Dialog File (#101.41)
 ;Non-Va entry with new sequences
 ;
 Q
 ;
EN ;entry point for post install
 N ORIEN,ORITEM,ORPARENT
 S ORIEN=$O(^ORD(101.41,"B","PSH OERR",0))
 S ORPARENT=$O(^ORD(101.41,"B","OR GTX INSTRUCTIONS",0))
 I 'ORIEN D  Q
 . D BMES^XPDUTL
 . D MES^XPDUTL("******************************************************************")
 . D MES^XPDUTL("* ERROR Dialog PSH OERR was not found in the ORDER DIALOG file!! *")
 . D MES^XPDUTL("*                                                                *")
 . D MES^XPDUTL("* This is required for patch OR*3*405 to function properly.      *")
 . D MES^XPDUTL("* Post Install Aborting...                                       *")
 . D MES^XPDUTL("******************************************************************")
 . D BMES^XPDUTL
 . D MAILERR
 . H 5
 ;continue and update Dialog
 D BMES^XPDUTL
 D MES^XPDUTL("Updtating PSH OERR order dialog...")
 D SETDATA
 D MES^XPDUTL("Completed")
 D BMES^XPDUTL
 Q
 ;
SETDATA ;
 N I,OREC,OREC1
 F I=1:1 S OREC=$P($T(TEXT1+I),";;",2) Q:OREC="QUIT"  D
 .S OREC1=$P($T(TEXT+I),";;",2)
 .S:$P(OREC,"^")=2.4 OREC1=OREC1_"~"_$P($T(TEXT2+I),";;",2),ORITEM=$O(^ORD(101.41,"B","OR GTX AND/THEN",0))
 .S:$P(OREC,"^")=2.3 ORITEM=$O(^ORD(101.41,"B","OR GTX DURATION",0))
 .S:$P(OREC,"^")=2.8 ORITEM=$O(^ORD(101.41,"B","OR GTX SCHEDULE TYPE",0))
 .D UPDATE
 Q
 ;
UPDATE ;setup die call
 K DR,DIC,DD,DA,DO,DINUM,FDA
 S DIC="^ORD(101.41,"
 S DA(1)=ORIEN
 S FDA(101.412,"?+1,"_DA(1)_",",.01)=$P((OREC),"^")
 S FDA(101.412,"?+1,"_DA(1)_",",.1)=$P((OREC1),"~")
 S FDA(101.412,"?+1,"_DA(1)_",",1)=ORPARENT
 S FDA(101.412,"?+1,"_DA(1)_",",2)=ORITEM
 S FDA(101.412,"?+1,"_DA(1)_",",4)=$P((OREC),"^",4)
 S FDA(101.412,"?+1,"_DA(1)_",",9)=$P((OREC),"^",9)
 S FDA(101.412,"?+1,"_DA(1)_",",13)=$P((OREC1),"~",3)
 S FDA(101.412,"?+1,"_DA(1)_",",11)=$P((OREC1),"~",2)
 S FDA(101.412,"?+1,"_DA(1)_",",15)=$P((OREC1),"~",4)
 S FDA(101.412,"?+1,"_DA(1)_",",19)=$P((OREC1),"~",5)
 S FDA(101.412,"?+1,"_DA(1)_",",20)=$P((OREC1),"~",6)
 S FDA(101.412,"?+1,"_DA(1)_",",17)=$P((OREC1),"~",7)
 D UPDATE^DIE("","FDA")
 K FDA
 Q
 ;
MAILERR ;Send err message to insatller mailman
 N ORTEXT
 S XMY(DUZ)=DUZ
 S XMSUB="OR*3*405 ** INSTALL ERROR ** NON-VA MEDICATIONS"
 S ORTEXT(1)="ERROR Dialog PSH OERR was not found in the ORDER DIALOG file!!"
 S ORTEXT(2)=""
 S ORTEXT(3)="This is required for patch OR*3*405 to function properly."
 S ORTEXT(4)="Post Install Aborted Prematurely."
 S ORTEXT(5)=""
 S XMTEXT="ORTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
TEXT ;dialog text
 ;;D INPCONJ^ORCDPS1~Enter AND if the next dose is to be administered concurrently with this one, or THEN if it is to follow after~I $G(ORCOMPLX)~I $G(ORESET)'=$P(Y,U) D CHANGED^ORCDPS1("QUANTITY")~D ENCONJ^ORCDPS1
 ;;~Enter the length of time over which this Non-VA Medication is being taken~I $$ASKDUR^ORCDPS3~D DUR^ORCDPS3~~~Q  I $G(ORTYPE)'="Z",$G(ORCAT)="I",$G(ORCOMPLX),$P($G(ORSD),U,3) S Y=+$P(ORSD,U,3)_" DAYS"
 ;;~~I 0
 ;;QUIT
TEXT1 ;dialog text
 ;;2.4^^^^^^^^^^
 ;;2.3^^^How Long:^^^^^C^^
 ;;2.8^^^^^^^^*^^
 ;;QUIT
TEXT2 ;ONLY FOR SEQUENCE 2.4
 ;;I $G(ORCOMPLX),'$L($G(ORDIALOG(PROMPT,INST))),FIRST S MAX=1
 Q
 ;
INDPR ;adding OR GTX INDICATION entry to ORDER DIALOG file ;*405-IND
 N ORIND,ORITEM,FDA,DA,ORSTA
 S ORIND="OR GTX INDICATION"
 S ORITEM=$O(^ORD(101.41,"B",ORIND,0))
 D BMES^XPDUTL
 I ORITEM D  Q
 . D MES^XPDUTL("******************************************************************")
 . D MES^XPDUTL("* OR GTX INDICATION already exists in ORDER DIALOG (#101.41) file*")
 . D MES^XPDUTL("* Quitting from here....                                         *")
 . D MES^XPDUTL("******************************************************************")
 . D BMES^XPDUTL
 D MES^XPDUTL("*******************************************************************")
 D MES^XPDUTL("*Adding OR GTX INDICATION entry to the ORDER DIALOG (#101.41) file*")
 D MES^XPDUTL("*******************************************************************")
 D BMES^XPDUTL
 S FDA(101.41,"?+1,",.01)=ORIND
 S FDA(101.41,"?+1,",2)="Indication:"
 S FDA(101.41,"?+1,",4)="P"
 S FDA(101.41,"?+1,",11)="F"
 S FDA(101.41,"?+1,",12)="3:40"
 S FDA(101.41,"?+1,",13)="INDICATION"
 D UPDATE^DIE("","FDA","ORSTA")
 I $G(ORSTA)'=""!('$G(ORSTA(1))) D  Q
 . D MES^XPDUTL("*******************************************************************")
 . D MES^XPDUTL("*OR GTX INDICATION addition failed. Quitting from here....        *")
 . D MES^XPDUTL("*******************************************************************")
 . D BMES^XPDUTL
 Q
 ;
INDPT ;adding OR GTX INDICATION to the order dialog listed in OPT
 N ORIND,ORITEM,FDA,DA,ORSTA,ORIEN,I,OPTX,REQ,ZZ,ORD
 S ORIND="OR GTX INDICATION"
 S ORITEM=$O(^ORD(101.41,"B",ORIND,0))
 I 'ORITEM D  Q
 . D MES^XPDUTL("******************************************************************")
 . D MES^XPDUTL("* OR GTX INDICATION does not exist in ORDER DIALOG (#101.41) file*")
 . D MES^XPDUTL("* Quitting order dialog updates..................................*")
 . D MES^XPDUTL("******************************************************************")
 . D BMES^XPDUTL
 F I=1:1 S OPTX=$P($T(OPT+I),";;",2) Q:OPTX=""  D
 . S REQ=1 S:OPTX="PSH OERR"!(OPTX="PSO SUPPLY") REQ=0
 . S ORIEN=$O(^ORD(101.41,"B",OPTX,0)) I 'ORIEN D  Q
 .. D BMES^XPDUTL
 .. D MES^XPDUTL("******************************************************************")
 .. D MES^XPDUTL("* "_OPTX_" was not found in the *")
 .. D MES^XPDUTL("* ORDER DIALOG (#101.41) file!!                                  *")
 .. D MES^XPDUTL("******************************************************************")
 . D ADDITEM
 ;allow Park or Clinic for Pick Up in quick order dialog
 F ZZ="PSO OERR","PSO SUPPLY" S ORD=$O(^ORD(101.41,"B",ZZ,0)) Q:'ORD  D
 . S I=0 F  S I=$O(^ORD(101.41,ORD,10,I)) Q:'I  I ^(I,0)["Pick Up:" D  Q
 .. S ^ORD(101.41,ORD,10,I,.1)="D PARKCK^ORCDPS3",^ORD(101.41,ORD,10,I,5)=""
 .. S ^ORD(101.41,ORD,10,I,1)="Enter if the patient is to receive this medication by mail, at the window, or to be parked."
 D BMES^XPDUTL
 D MES^XPDUTL("****..Completed..****")
 D BMES^XPDUTL
 Q
 ;
ADDITEM ;
 K FDA,DA
 S DA(1)=ORIEN
 S FDA(101.412,"?+1,"_DA(1)_",",.01)=8.5
 S FDA(101.412,"?+1,"_DA(1)_",",.1)="D INDIT^ORCDPS3"
 S FDA(101.412,"?+1,"_DA(1)_",",2)=ORITEM
 S FDA(101.412,"?+1,"_DA(1)_",",4)="Indication: "
 S:REQ FDA(101.412,"?+1,"_DA(1)_",",6)=1
 S FDA(101.412,"?+1,"_DA(1)_",",11)="You can choose a common indication from the list or free text an indication between 3-40 characters. "
 S FDA(101.412,"?+1,"_DA(1)_",",11)=FDA(101.412,"?+1,"_DA(1)_",",11)_"This field is not required in a quick order. If left blank the provider will have to fill it during order entry."
 S FDA(101.412,"?+1,"_DA(1)_",",16)="D XHELP^ORCDPS3:$G(ORDIALOG(PROMPT,""LIST""))"
 S FDA(101.412,"?+1,"_DA(1)_",",17)="D DFIND^ORCDPS3"
 S FDA(101.412,"?+1,"_DA(1)_",",19)="D IND^ORCDPS3"
 S FDA(101.412,"?+1,"_DA(1)_",",20)="I $L(Y) W ""   ""_Y"
 S FDA(101.412,"?+1,"_DA(1)_",",21)=20
 S FDA(101.412,"?+1,"_DA(1)_",",24)="Indication:"
 S FDA(101.412,"?+1,"_DA(1)_",",26)=1
 I $D(^ORD(101.41,DA(1),10,"B",8.5)) D MES^XPDUTL("...updating  "_OPTX_" with "_ORIND)
 I '$D(^ORD(101.41,DA(1),10,"B",8.5)) D MES^XPDUTL("...adding  "_OPTX_" with "_ORIND)
 D UPDATE^DIE("","FDA")
 Q
 ;
OPT ;
 ;;PSO OERR
 ;;PSJ OR PAT OE
 ;;PSJI OR PAT FLUID OE
 ;;PSO SUPPLY
 ;;PSH OERR
 ;;PS MEDS
 ;;PSJ OR CLINIC OE
 ;;CLINIC OR PAT FLUID OE
 Q
 ;
CLINMED ;
 ;
 ; Remove the Route and Days supply prompts from PSJ OR CLINIC OE since
 ; they are not needed for Clin Meds and prevent QOs from being Auto Accepted
 ;
 N DA,DIK,ORDAYDLGIEN,ORDLG,ORIMODLGIEN,ORRTNGDLGIEN,ORX
 ;
 D BMES^XPDUTL("Updating 'PSJ OR CLINIC OE'... removing Route and Days Supply prompts.")
 ;
 S ORIMODLGIEN=$O(^ORD(101.41,"B","PSJ OR CLINIC OE",0))
 S ORDAYDLGIEN=$O(^ORD(101.41,"B","OR GTX DAYS SUPPLY",0))
 S ORRTNGDLGIEN=$O(^ORD(101.41,"B","OR GTX ROUTING",0))
 I 'ORIMODLGIEN!('ORDAYDLGIEN)!('ORRTNGDLGIEN) D  Q
 . S ORX=$S('ORIMODLGIEN:"PSJ OR CLINIC OE",'ORDAYDLGIEN:"OR GTX DAYS SUPPLY",1:"OR GTX ROUTING")
 . D MES^XPDUTL("**************************************************************************")
 . D MES^XPDUTL("* ERROR Dialog "_ORX_" was not found in the ORDER DIALOG file!! *")
 . D MES^XPDUTL("*                                                                        *")
 . D MES^XPDUTL("* This is required for patch OR*3*405 to function properly.              *")
 . D MES^XPDUTL("**************************************************************************")
 ;
 F ORDLG=ORDAYDLGIEN,ORRTNGDLGIEN D
 . S DA=$O(^ORD(101.41,ORIMODLGIEN,10,"D",ORDLG,0))
 . I 'DA D  Q
 . . D MES^XPDUTL($S(ORDLG=ORDAYDLGIEN:"OR GTX DAYS SUPPLY",1:"OR GTX ROUTING")_" already removed from PSJ OR CLINIC OE.")
 . S DA(1)=ORIMODLGIEN
 . S DIK="^ORD(101.41,"_DA(1)_",10,"
 . D ^DIK
 . D MES^XPDUTL("Removing "_$S(ORDLG=ORDAYDLGIEN:"OR GTX DAYS SUPPLY",1:"OR GTX ROUTING")_" from PSJ OR CLINIC OE.")
 ;
 D BMES^XPDUTL
 ;
 Q
 ;
