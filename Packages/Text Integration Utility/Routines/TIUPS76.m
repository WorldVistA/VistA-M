TIUPS76 ; SLC/JER - Post-install for TIU*1*76 ; 7/27/1999
 ;;1.0;TEXT INTEGRATION UTILITIES;**76**;Jun 20, 1997
MAIN ; Do it!
 N ROOTDA,TITLDA,OBJDA,ITMLST,TREE
 S TIUPOP=$$RUNCHECK
 I +TIUPOP D  Q
 . D BMES^XPDUTL("This routine has already been run...")
 D SETROOT(.ROOTDA) ; Create Primary Shared Templates Root
 D SETITLE(.TITLDA) ; Create Inactive Folder for Boilerplated TITLES
 D WRAPTTLS(TITLDA)
 D SETOBJ(.OBJDA)   ; Create Active Folder for all ACTIVE TIU OBJECTS
 D WRAPOBJS(OBJDA)
 ; Add Boilerplated Titles and Patient Data Objects as items to ROOT
 D BMES^XPDUTL("Adding Boilerplated Titles and Patient Data Objects to Shared Templates...")
 S ITMLST(1)=TITLDA,ITMLST(2)=OBJDA
 D BLDTREE(.TREE,ROOTDA,.ITMLST)
 S ^TIU(8927,"PS76")=""
 Q
RUNCHECK() ; Check whether this code has already run
 I $D(^TIU(8927,"PS76")) Q 1
 I +$O(^TIU(8927,"B","Shared Templates",0)) Q 1
 I +$O(^TIU(8927,"B","Boilerplated Titles",0)) Q 1
 I +$O(^TIU(8927,"B","Patient Data Objects",0)) Q 1
 I +$O(^TIU(8927,"B","TIU Objects",0)) Q 1
 I +$O(^TIU(8927,"B","Boilerplate Titles",0)) Q 1
 Q 0
SETROOT(SUCCESS) ; Create the primary Root called Shared Templates
 N TIUDA,TIUX S TIUDA=+$O(^TIU(8927,"B","Shared Templates",0))
 S TIUX(.01)="Shared Templates"
 S TIUX(.03)="R"
 S TIUX(.04)="A"
 S TIUX(.07)=+$$CLPAC^TIUSRVT1
 D SETTMPLT^TIUSRVT(.SUCCESS,TIUDA,.TIUX)
 I '+SUCCESS D BMES^XPDUTL($P(SUCCESS,U,2)) Q
 D BMES^XPDUTL("Shared Templates Root Created.")
 Q
SETITLE(SUCCESS) ; Create Inactive Folder for Boilerplated Titles
 N TIUDA,TIUX S TIUDA=+$O(^TIU(8927,"B","Boilerplated Titles",0))
 S TIUX(.01)="Boilerplated Titles"
 S TIUX(.03)="C"
 S TIUX(.04)="I"
 D SETTMPLT^TIUSRVT(.SUCCESS,TIUDA,.TIUX)
 I '+SUCCESS D BMES^XPDUTL($P(SUCCESS,U,2)) Q
 D BMES^XPDUTL("Boilerplated Titles Folder Created.")
 Q
WRAPTTLS(TTLGRP) ; Create Template "wrappers" for Titles w/BP text
 N TIUDA,DCTREE,DCINDX,ITMSEQ S (TTLSEQ,TIUDA)=0
 F  S TIUDA=$O(^TIU(8925.1,TIUDA)) Q:+TIUDA'>0  D
 . N TIUX,TIUTNM,TIUD0,TTLTMP,CNTNR
 . S TIUD0=$G(^TIU(8925.1,TIUDA,0))
 . Q:+$P(TIUD0,U,7)'=11  ; Exclude INACTIVE DDEFS
 . ; Only allow TITLES or COMPONENTS
 . I $S($P(TIUD0,U,4)="DOC":0,$P(TIUD0,U,4)="CO":0,1:1) Q
 . ; Quit if no Boilerplate Text is present
 . I '+$O(^TIU(8925.1,TIUDA,"DFLT",0)) Q
 . I $P(TIUD0,U,4)="CO" D MAKECONT(.CNTNR,TIUDA,$P(TIUD0,U,4))
 . S TIUTNM=$P(TIUD0,U)
 . M TIUX(2)=^TIU(8925.1,TIUDA,"DFLT")
 . D MAKEWRAP(.TTLTMP,$$MIXED^TIULS(TIUTNM),.TIUX)
 . I +TTLTMP>0 D
 . . I +$G(CNTNR)'>0 D ADDITEM(TTLGRP,TTLTMP) Q
 . . D ADDITEM(CNTNR,TTLTMP),ADDITEM(TTLGRP,CNTNR)
 Q
MAKECONT(CNTNR,TIUDA,TYPE) ; Find/Create folder
 N MOMDA,MOMD0,MOMNM,MOMTTYPE
 S MOMDA=+$O(^TIU(8925.1,"AD",TIUDA,0)) Q:'MOMDA
 S MOMD0=$G(^TIU(8925.1,MOMDA,0)) Q:(MOMD0="")
 S MOMNM=$$MIXED^TIULS($P(MOMD0,U)),MOMTTYPE=$S(TYPE="CO":"G",1:"C")
 S MOMTDA=$O(^TIU(8927,"B",MOMNM,0))
 ; If the appropriate folder exists, use it
 I +MOMTDA,($P(^TIU(8927,MOMTDA,0),U,3)=MOMTTYPE) S CNTNR=MOMTDA Q
 ; Otherwise, create it
 S TIUX(.01)=MOMNM
 S TIUX(.03)=MOMTTYPE
 S TIUX(.04)="A"
 D SETTMPLT^TIUSRVT(.CNTNR,MOMTDA,.TIUX)
 I +CNTNR D BMES^XPDUTL("  "_MOMNM_" Folder added.")
 Q
ADDITEM(PARENT,ITEM) ; Add Item to Parent
 N TIUSUCC,TIUI,TIUITEM
 Q:+$O(^TIU(8927,"AD",ITEM,PARENT,0))
 S TIUI=+$P($G(^TIU(8927,+PARENT,10,0)),U,3)+1
 S TIUITEM(.01)=TIUI,TIUITEM(.02)=ITEM
 D UPDATE^TIUSRVT1(.TIUSUCC,"""+"_TIUI_","_PARENT_",""",.TIUITEM)
 Q
SETOBJ(SUCCESS) ; Create Active Folder for all ACTIVE TIU OBJECTS
 N TIUDA,TIUX S TIUDA=+$O(^TIU(8927,"B","Patient Data Objects",0))
 S TIUX(.01)="Patient Data Objects"
 S TIUX(.03)="C"
 S TIUX(.04)="A"
 D SETTMPLT^TIUSRVT(.SUCCESS,TIUDA,.TIUX)
 I '+SUCCESS D BMES^XPDUTL($P(SUCCESS,U,2)) Q
 D BMES^XPDUTL("Patient Data Objects Folder Created.")
 Q
WRAPOBJS(OBJGRP) ; Create Template "wrappers" for ACTIVE Objects
 N TIUDA,ITMLST,ITMSEQ,OBJECTS,TIUONM S (ITMSEQ,TIUDA)=0
 F  S TIUDA=$O(^TIU(8925.1,"AT","O",TIUDA)) Q:+TIUDA'>0  D
 . N TIUX,TIUTNM,TIUOD0,OBJTMP
 . S TIUOD0=$G(^TIU(8925.1,TIUDA,0))
 . Q:+$P(TIUOD0,U,7)'=11  ; Exclude INACTIVE OBJECTS
 . S TIUTNM=$P(TIUOD0,U)
 . S TIUX(2,1,0)="|"_TIUTNM_"|"
 . D MAKEWRAP(.OBJTMP,$$MIXED^TIULS(TIUTNM),.TIUX)
 . I +OBJTMP>0 D
 . . S ITMLST($$UP^XLFSTR(TIUTNM))=OBJTMP
 S TIUONM=""
 F  S TIUONM=$O(ITMLST(TIUONM)) Q:TIUONM=""  D
 . S ITMSEQ=ITMSEQ+1
 . S ITMLST(ITMSEQ)=ITMLST(TIUONM)
 . K ITMLST(TIUONM)
 I +$O(ITMLST(0)) D SETITEMS^TIUSRVT(.OBJECTS,OBJGRP,.ITMLST)
 Q
MAKEWRAP(WRAPTEMP,TIUTNM,TIUX) ; Create a single wrapper
 N TIUDA S TIUDA=+$O(^TIU(8927,"B",TIUTNM,0))
 S TIUX(.01)=TIUTNM
 S TIUX(.03)="T"
 S TIUX(.04)="A"
 D SETTMPLT^TIUSRVT(.WRAPTEMP,TIUDA,.TIUX)
 I +WRAPTEMP D BMES^XPDUTL("  "_TIUTNM_" Template ""wrapper"" added.")
 Q
BLDTREE(TREE,ROOTDA,ITMLST) ; Add Boilerplated Titles and
 ;                         Patient Data Objects as items to ROOT
 D SETITEMS^TIUSRVT(.TREE,ROOTDA,.ITMLST)
 Q
