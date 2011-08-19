ORQQPX ; SLC/JM - PCE and Reminder routines ;11/16/2004
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,184,187,190,226**;Dec 17, 1997
 Q
IMMLIST(ORY,ORPT) ;return pt's immunization list:
 ;id^name^date/time^reaction^inverse d/t
 I $L($T(IMMUN^PXRHS03))<1 S ORY(1)="^Immunizations not available." Q
 K ^TMP("PXI",$J)
 D IMMUN^PXRHS03(ORPT)
 N ORI,IMM,IVDT,IEN,X
 S ORI=0,IMM="",IVDT="",IEN=0
 F  S IMM=$O(^TMP("PXI",$J,IMM)) Q:IMM=""  D
 .F  S IVDT=$O(^TMP("PXI",$J,IMM,IVDT)) Q:IVDT=""  D
 ..F  S IEN=$O(^TMP("PXI",$J,IMM,IVDT,IEN)) Q:IEN<1  D
 ...S ORI=ORI+1,X=$G(^TMP("PXI",$J,IMM,IVDT,IEN,0)) Q:'$L(X)
 ...S ORY(ORI)=IEN_U_IMM_U_$P(X,U,3)
 ...I $P(X,U,7)=1 S ORY(ORI)=ORY(ORI)_U_$P(X,U,6)_U_IVDT
 ...E  S ORY(ORI)=ORY(ORI)_U_U_IVDT
 S:+$G(ORY(1))<1 ORY(1)="^No immunizations found.^2900101^^9999999"
 K ^TMP("PXI",$J)
 Q
DETAIL(ORY,IMM) ; return detailed information for an immunization
 S ORY(1)="Detailed information on immunizations is not available."
 Q
REMIND(ORY,ORPT) ;return pt's currently due PCE clinical reminders
 ; in the format file 811.9 ien^reminder print name^date due^last occur.
 N ORTMPLST,ORI,ORJ,ORIEN,ORTXT,ORX,ORLASTDT,ORDUEDT,ORLOC
 S ORJ=0
 ;
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 I +$G(ORPT)>0 D
 .N DFN S DFN=ORPT,VA200="" D OERR^VADPT
 .I +$G(VAIN(4))>0 S ORLOC=+$G(^DIC(42,+$G(VAIN(4)),44))
 .K VA200,VAIN
 ;
 D REMLIST(.ORTMPLST,$G(ORLOC))
 ;D GETLST^XPAR(.ORTMPLST,"USR^LOC.`"_$G(ORLOC)_"^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQPX SEARCH ITEMS","Q",.ORERR)
 ;I ORERR>0 S ORY(1)=U_"Error: "_$P(ORERR,U,2) Q
 S ORI=0 F  S ORI=$O(ORTMPLST(ORI)) Q:'ORI  D
 .S ORIEN=$P(ORTMPLST(ORI),U,2)
 .K ^TMP("PXRHM",$J)
 .N ORPRI,ORDUE,ORSTA
 .D MAIN^PXRM(ORPT,ORIEN,0)
 .S ORTXT="",ORTXT=$O(^TMP("PXRHM",$J,ORIEN,ORTXT)) Q:ORTXT=""  D
 ..S ORX=^TMP("PXRHM",$J,ORIEN,ORTXT)
 ..S ORSTA=$P(ORX,U)
 ..S ORDUEDT=$P(ORX,U,2),ORLASTDT=$P(ORX,U,3)
 ..S ORLASTDT=$S(+$G(ORLASTDT)>0:ORLASTDT,1:"")  ;null if not a date
 ..S ORJ=ORJ+1
 ..S ORDUE=$S(ORSTA["DUE":1,ORSTA["ERROR":3,ORSTA["CNBD":4,1:2)
 ..I ORDUE'=2 D
 ...S ORPRI=$P($G(^PXD(811.9,ORIEN,0)),U,10) I ORPRI="" S ORPRI=2
 ...S ORY(ORJ)=ORIEN_U_ORTXT_U_ORDUEDT_U_ORLASTDT_U_ORPRI_U_ORDUE_U_$$DLG^PXRMRPCA(ORIEN)_U_U_U_U_$$DLGWIPE^PXRMRPCA(ORIEN)
 ..I ORDUE=2 D
 ...S ORY(ORJ)=ORIEN_U_ORTXT_U_U_U_U_ORDUE_U_$$DLG^PXRMRPCA(ORIEN)_U_U_U_U_$$DLGWIPE^PXRMRPCA(ORIEN)
 .K ^TMP("PXRHM",$J)
 Q
REMDET(ORY,ORPT,ORIEN) ;return detail for a pt's clinical reminder
 ; ORY - return array
 ; ORPT - patient DFN
 ; ORIEN - clinical reminder (811.9 ien)
 K ^TMP("PXRHM",$J)
 D MAIN^PXRM(ORPT,ORIEN,5)     ; 5 returns all reminder info
 N CR,I,J,ORTXT S I=1
 S ORTXT="",ORTXT=$O(^TMP("PXRHM",$J,ORIEN,ORTXT)) Q:ORTXT=""  D
 .S J=0 F  S J=$O(^TMP("PXRHM",$J,ORIEN,ORTXT,"TXT",J)) Q:J=""  D
 ..S ORY(I)=^TMP("PXRHM",$J,ORIEN,ORTXT,"TXT",J),I=I+1
 K ^TMP("PXRHM",$J)
 Q
NEWACTIV(ORY) ;Return true if Interactive Reminders are active
 S ORY=0
 I $T(APPL^PXRMRPCA)'="",+$G(DUZ) D
 . N SRV
 . ;S SRV=$P($G(^VA(200,DUZ,5)),U)
 . S SRV=$$GET1^DIQ(200,DUZ,29,"I")
 . S ORY=$$GET^XPAR(DUZ_";VA(200,^SRV.`"_+$G(SRV)_"^DIV^SYS","PXRM GUI REMINDERS ACTIVE",1,"Q")
 . I +ORY S ORY=1
 . E  S ORY=0
 Q
HISTLOC(LST) ;Returns a list of historical locations
 N IDX,PTR,LINE,NAME
 K ^TMP("OR",$J,"LOC")
 S LST=$NA(^TMP("OR",$J,"LOC"))
 S (LINE,IDX)=0
 F  S IDX=$O(^AUTTLOC(IDX)) Q:'IDX  D
 .S PTR=+$G(^AUTTLOC(IDX,0))
 .I +PTR D
 ..;S NAME=$P($G(^DIC(4,PTR,0)),U)
 ..S NAME=$$GET1^DIQ(4,PTR,.01,"I")
 ..I NAME'="" D
 ...S LINE=LINE+1
 ...S ^TMP("OR",$J,"LOC",LINE)=PTR_U_NAME
 Q
GETFLDRS(ORFLDRS) ;Return Visible Reminder Folders
 ; Codes: D=Due, A=Applicable, N=Not Applicable, E=Evaluated, O=Other
 N SRV,ORERR,ORTMP
 ;S SRV=$P($G(^VA(200,DUZ,5)),U)
 S SRV=$$GET1^DIQ(200,DUZ,29,"I")
 D GETLST^XPAR(.ORTMP,"USR^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORQQPX REMINDER FOLDERS","Q",.ORERR)
 I +ORTMP S ORFLDRS=$P($G(ORTMP(1)),U,2)
 E  S ORFLDRS="DAO"
 Q
SETFLDRS(ORY,ORFLDRS) ;Sets Visible Reminder Folders for the current user
 N ORERR
 D EN^XPAR(DUZ_";VA(200,","ORQQPX REMINDER FOLDERS",1,ORFLDRS,.ORERR)
 S ORY=1
 Q
GETDEFOL(ORDEFLOC) ;Return Default Outside Locations
 N SRV,ORERR
 ;S SRV=$P($G(^VA(200,DUZ,5)),U)
 S SRV=$$GET1^DIQ(200,DUZ,29,"I")
 D GETLST^XPAR(.ORDEFLOC,"USR^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORQQPX DEFAULT LOCATIONS","Q",.ORERR)
 Q
INSCURS(ORY) ; Returns status of ORQQPX REMINDER TEXT AT CURSOR
 N SRV,ORERR,ORTMP
 ;S ORY=0,SRV=$P($G(^VA(200,DUZ,5)),U)
 S ORY=0,SRV=$$GET1^DIQ(200,DUZ,29,"I")
 D GETLST^XPAR(.ORTMP,"USR^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORQQPX REMINDER TEXT AT CURSOR","Q",.ORERR)
 I +ORTMP S ORY=$P($G(ORTMP(1)),U,2)
 Q
NEWCVOK(ORY) ; Returns status of 
 N SRV,ORERR,ORTMP
 ;S ORY=0,SRV=$P($G(^VA(200,DUZ,5)),U)
 S ORY=0,SRV=$$GET1^DIQ(200,DUZ,29,"I")
 D GETLST^XPAR(.ORTMP,"USR^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORQQPX NEW REMINDER PARAMS","Q",.ORERR)
 I +ORTMP S ORY=$P($G(ORTMP(1)),U,2)
 Q
ADDNAME(ORX) ; Add Reminder or Category Name as 3rd piece
 N CAT,IEN
 S CAT=$E($P(ORX,U,2),2)
 S IEN=$E($P(ORX,U,2),3,99)
 I +IEN D
 .I CAT="R" S $P(ORX,U,3)=$P($G(^PXD(811.9,IEN,0)),U,3)
 .I CAT="C" S $P(ORX,U,3)=$P($G(^PXRMD(811.7,IEN,0)),U)
 Q ORX
REMACCUM(ORY,LVL,TYP,SORT,CLASS) ; Accumulates ORTMP into ORY
 ; Format of entries in ORQQPX COVER SHEET REMINDERS:
 ;   L:Lock;R:Remove;N:Normal / C:Category;R:Reminder / Cat or Rem IEN
 N IDX,I,J,K,M,FOUND,ORERR,ORTMP,FLAG,IEN
 N FFLAG,FIEN,OUT,P2,ADD,DOADD,CODE
 I LVL="CLASS" D  I 1
 .N ORLST,ORCLS,ORCLSPRM,ORWP
 .S ORCLSPRM="ORQQPX COVER SHEET REM CLASSES"
 .D GETLST^XPAR(.ORLST,"SYS",ORCLSPRM,"Q",.ORERR)
 .S I=0,M=0,CLASS=$G(CLASS)
 .F  S I=$O(ORLST(I)) Q:'I  D
 ..S ORCLS=$P(ORLST(I),U,1)
 ..I +CLASS S ADD=(ORCLS=+CLASS) I 1
 ..E  S ADD=$$ISA^USRLM(DUZ,ORCLS,.ORERR)
 ..I +ADD D
 ...D GETWP^XPAR(.ORWP,"SYS",ORCLSPRM,ORCLS,.ORERR)
 ...S K=0
 ...F  S K=$O(ORWP(K)) Q:'K  D
 ....S M=M+1
 ....S J=$P(ORWP(K,0),";",1)
 ....S ORTMP(M)=J_U_$P(ORWP(K,0),";",2)
 E  D GETLST^XPAR(.ORTMP,LVL,"ORQQPX COVER SHEET REMINDERS",TYP,.ORERR)
 S I=0,IDX=$O(ORY(999999),-1)+1,ADD=(SORT="")
 F  S I=$O(ORTMP(I)) Q:'I  D
 .S (FOUND,J)=0,P2=$P(ORTMP(I),U,2)
 .S FLAG=$E(P2),IEN=$E(P2,2,999)
 .I ADD S DOADD=1
 .E  D
 ..S DOADD=0
 ..F  S J=$O(ORY(J)) Q:'J  D  Q:FOUND
 ...S P2=$P(ORY(J),U,2)
 ...S FIEN=$E(P2,2,999)
 ...I FIEN=IEN S FOUND=J,FFLAG=$E(P2)
 ..I FOUND D  I 1
 ...I FLAG="R",FFLAG'="L" K ORY(FOUND)
 ...I FLAG'=FFLAG,(FLAG_FFLAG)["L" S $E(P2)="L",$P(ORY(FOUND),U,2)=P2
 ..E  I (FLAG'="R") S DOADD=1
 .I DOADD D
 ..S OUT(IDX)=ORTMP(I)
 ..S $P(OUT(IDX),U)=$P(OUT(IDX),U)_SORT
 ..I SORT="" S OUT(IDX)=$$ADDNAME(OUT(IDX))
 ..S IDX=IDX+1
 M ORY=OUT
 Q
ADDREM(ORY,IDX,IEN) ; Add Reminder to ORY list
 I $D(ORY("B",IEN)) Q               ; See if it's in the list
 I '$D(^PXD(811.9,IEN)) Q           ; Check if Exists
 I $P($G(^PXD(811.9,IEN,0)),U,6)'="" Q  ; Check if Active
 ;check to see if the reminder is assigned to CPRS
 I $P($G(^PXD(811.9,IEN,100)),U,4)["L" Q
 I $P($G(^PXD(811.9,IEN,100)),U,4)'["C",$P($G(^PXD(811.9,IEN,100)),U,4)'="*" Q
 S ORY(IDX)=IDX_U_IEN
 S ORY("B",IEN)=""
 Q
ADDCAT(ORY,IDX,IEN) ; Add Category Reminders to ORY list
 N ORREM,I,IDX2,NREM
 D CATREM^PXRMAPI0(IEN,.ORREM)
 S I=0
 F  S I=$O(ORREM(I)) Q:'I  D
 . S IDX2="00000"_I
 . S IDX2=$E(IDX2,$L(IDX2)-5,99)
 . D ADDREM(.ORY,+(IDX_"."_IDX2),$P(ORREM(I),U,1))
 Q
REMLIST(ORY,LOC) ;Returns a list of all cover sheet reminders
 N SRV,I,J,ORLST,CODE,IDX,IEN,NEWP
 ;S SRV=$P($G(^VA(200,DUZ,5)),U)
 S SRV=$$GET1^DIQ(200,DUZ,29,"I")
 D NEWCVOK(.NEWP)
 I 'NEWP D GETLST^XPAR(.ORY,"USR^LOC.`"_$G(LOC)_"^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORQQPX SEARCH ITEMS","Q",.ORERR) Q
 D REMACCUM(.ORLST,"PKG","Q",1000)
 D REMACCUM(.ORLST,"SYS","Q",2000)
 D REMACCUM(.ORLST,"DIV","Q",3000)
 I +SRV D REMACCUM(.ORLST,"SRV.`"_+$G(SRV),"Q",4000)
 I +LOC D REMACCUM(.ORLST,"LOC.`"_+$G(LOC),"Q",5000)
 D REMACCUM(.ORLST,"CLASS","Q",6000)
 D REMACCUM(.ORLST,"USR","Q",7000)
 S I=0
 F  S I=$O(ORLST(I)) Q:'I  D
 .S IDX=$P(ORLST(I),U,1)
 .F  Q:'$D(ORY(IDX))  S IDX=IDX+1
 .S CODE=$E($P(ORLST(I),U,2),2)
 .S IEN=$E($P(ORLST(I),U,2),3,999)
 .I CODE="R" D ADDREM(.ORY,IDX,IEN)
 .I CODE="C" D ADDCAT(.ORY,IDX,IEN)
 K ORY("B")
 Q
LVREMLST(ORY,LVL,CLASS) ;Returns cover sheet reminders at a specified level
 D REMACCUM(.ORY,LVL,"Q","",$G(CLASS))
 Q
SAVELVL(ORY,LVL,CLASS,DATA) ;Save cover sheet reminders at a specified level
 N ORERR,PARAM,I
 I LVL="CLASS" D  I 1
 .S PARAM="ORQQPX COVER SHEET REM CLASSES"
 .S LVL="SYS"
 .D DEL^XPAR(LVL,PARAM,"`"_CLASS,.ORERR)
 .D EN^XPAR(LVL,PARAM,"`"_CLASS,.DATA,.ORERR)
 E  D
 .S PARAM="ORQQPX COVER SHEET REMINDERS"
 .D NDEL^XPAR(LVL,PARAM,.ORERR)
 .S I=0
 .F  S I=$O(DATA(I)) Q:'I  D
 ..D EN^XPAR(LVL,PARAM,$P(DATA(I),U,1),$P(DATA(I),U,2),.ORERR)
 S ORY=1
 Q
GETLIST(ORY,ORLOC) ;Returns a list of all cover sheet reminders
 N I
 D REMLIST(.ORY,$G(ORLOC))
 S I=0
 F  S I=$O(ORY(I)) Q:'I  D
 .S ORY(I)=$P(ORY(I),U,2)
 Q
EVALCOVR(ORY,ORPT,ORLOC) ; Evaluate Cover Sheet Reminders
 N ORTMP
 D GETLIST(.ORTMP,$G(ORLOC))
 D ALIST^ORQQPXRM(.ORY,ORPT,.ORTMP)
 Q
