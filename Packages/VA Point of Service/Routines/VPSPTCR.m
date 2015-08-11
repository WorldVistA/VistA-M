VPSPTCR  ;BPIFO/KG - Patient DUE NOW Reminders RPC;07/03/14 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4**;Jul 3,2014;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #2051  - FIND1^DIC              (Supported)
 ; #2056  - GET1^DIQ               (Supported)
 ; #2263  - GETWP^XPAR             (Supported)
 ; #2263  - GETLST^XPAR            (Supported)
 ; #2182  - MAIN^PXRM              (Controlled Subs)
 ; #3333  - CATREM^PXRMAPI0        (Controlled Subs)
 ; #3960  - READ ACCESS TO File #811.7, Items .01                 (Controlled Subs)
 ; #6113  - READ ACCESS TO File #811.9, Items 1.2, 1.6, 1.91, 103 (Controlled Subs)
 ; #10060 - READ ACCESS TO File #200, Items 16,29                 (Supported)
 ; #1518  - READ ACCESS TO File #8989.3, Items 217                (Controlled Subs)
 Q
 ;
REMIND(RESULT,DFN,DIV,SRV,LOC,USRCL) ;RPC: VPS GET CLINICAL REMINDERS
 ;Returns a list of patient's currently due PCE clinical reminders
 ;Input Parameter(s):
 ; DFN - Patient Identifier (File #2)
 ; DIV - Division Identifier (File #4)
 ; SRV - Service Identifier (File #49)
 ; LOC - Location Identifier (File #44)
 ; USRCL - List of User Classes separated by "^" (File #8930)
 ;Output Parameter(s):
 ; RESULT - Passed by reference, list of due now reminders
 ;   Success : RESULT(0)=0, RESULT(1..n)= file 811.9 ien^reminder print name^date due^last occur.
 ;   Error   : RESULT(0)=-1^Error Message
 ;
 N VPSLST,VPSI,VPSJ,VPSIEN,VPSTXT,VPSX,VPSLSTDT,VPSDUEDT,VPSPRI,VPSDUE,VPSSTA
 ;
 ; -- validate patient ID
 I $G(DFN)="" S RESULT(0)="-1^PATIENT ID NOT SENT" Q
 I '$D(^DPT(DFN)) S RESULT(0)="-1^PATIENT "_DFN_" NOT FOUND" Q
 ;
 ; -- get all cover sheer reminder list
 D REMLIST(.VPSLST,$G(DIV),$G(SRV),$G(LOC),$G(USRCL))
 ;
 ; -- get clinical reminder for patient
 S VPSI=0,VPSJ=0
 F  S VPSI=$O(VPSLST(VPSI)) Q:'VPSI  D
 . S VPSIEN=$P(VPSLST(VPSI),U,2)
 . K ^TMP("PXRHM",$J)
 . D MAIN^PXRM(DFN,VPSIEN,0)
 . S VPSTXT="",VPSTXT=$O(^TMP("PXRHM",$J,VPSIEN,VPSTXT)) Q:VPSTXT=""  D
 . . S VPSX=^TMP("PXRHM",$J,VPSIEN,VPSTXT)
 . . S VPSSTA=$P(VPSX,U,1),VPSDUEDT=$P(VPSX,U,2),VPSLSTDT=$P(VPSX,U,3)
 . . S VPSLSTDT=$S(+$G(VPSLSTDT)>0:VPSLSTDT,1:"") ;null if not a date
 . . S VPSJ=VPSJ+1
 . . S VPSDUE=$S(VPSSTA["DUE":1,VPSSTA["ERROR":3,VPSSTA["CNBD":4,1:2)
 . . I VPSDUE'=2 D  I 1
 . . . S VPSPRI=$$GET1^DIQ(811.9,VPSIEN_",",1.91,"I") ;Priority
 . . . I VPSPRI="" S VPSPRI=2
 . . E  S VPSDUEDT="",VPSLSTDT="",VPSPRI=""
 . . S RESULT(VPSJ)=VPSIEN_U_VPSTXT_U_VPSDUEDT_U_VPSLSTDT_U_VPSPRI_U_VPSDUE  ;_U_$$DLG^PXRMRPCA(VPSIEN)_U_U_U_U_$$DLGWIPE^PXRMRPCA(VPSIEN)
 . K ^TMP("PXRHM",$J)
 ;
 I '$D(RESULT) S RESULT(0)="-1^NO CLINICAL REMINDERS FOUND FOR PATIENT "_DFN Q
 S RESULT(0)=1
 Q
 ;
REMACCUM(RESULT,LVL,TYP,SORT,CLASS) ;Gets Reminder data for each Parameter Entity
 ;Input Parameter(s):
 ; LVL - Parameter Entity
 ; TYP - Format of returned data
 ; SORT - Sort order for Reminders
 ; CLASS - User classes
 ;Output Parameter(s):
 ; RESULT - Sorted list of Reminders
 ; 
 ; Format of entries in ORQQPX COVER SHEET REMINDERS:
 ; L:Lock;R:Remove;N:Normal / C:Category;R:Reminder / Cat or Rem IEN
 N IDX,I,J,K,M,FOUND,VPSERR,VPSTMP,FLAG,IEN
 N FFLAG,FIEN,OUT,P2,ADD,DOADD,CODE
 I LVL="CLASS" D  I 1
 . N VPSLST,VPSCLS,VPSCLSPM,VPSWP
 . S VPSCLSPM="ORQQPX COVER SHEET REM CLASSES"
 . D GETLST^XPAR(.VPSLST,"SYS",VPSCLSPM,"Q",.VPSERR)
 . S I=0,M=0,CLASS=$G(CLASS)
 . F  S I=$O(VPSLST(I)) Q:'I  D
 . . S VPSCLS=$P(VPSLST(I),U,1)
 . . S ADD=0
 . . I CLASS]"" S ADD=(U_CLASS_U)[(U_VPSCLS_U)
 . . I +ADD D
 . . . D GETWP^XPAR(.VPSWP,"SYS",VPSCLSPM,VPSCLS,.VPSERR)
 . . . S K=0
 . . . F  S K=$O(VPSWP(K)) Q:'K  D
 . . . . S M=M+1
 . . . . S J=$P(VPSWP(K,0),";",1)
 . . . . S VPSTMP(M)=J_U_$P(VPSWP(K,0),";",2)
 E  D GETLST^XPAR(.VPSTMP,LVL,"ORQQPX COVER SHEET REMINDERS",TYP,.VPSERR)
 S I=0,IDX=$O(RESULT(999999),-1)+1,ADD=(SORT="")
 F  S I=$O(VPSTMP(I)) Q:'I  D
 . S (FOUND,J)=0,P2=$P(VPSTMP(I),U,2)
 . S FLAG=$E(P2),IEN=$E(P2,2,999)
 . I ADD S DOADD=1
 . E  D
 . . S DOADD=0
 . . F  S J=$O(RESULT(J)) Q:'J  D  Q:FOUND
 . . . S P2=$P(RESULT(J),U,2)
 . . . S FIEN=$E(P2,2,999)
 . . . I FIEN=IEN S FOUND=J,FFLAG=$E(P2)
 . . I FOUND D  I 1
 . . . I FLAG="R",FFLAG'="L" K RESULT(FOUND)
 . . . I FLAG'=FFLAG,(FLAG_FFLAG)["L" S $E(P2)="L",$P(RESULT(FOUND),U,2)=P2
 . . E  I (FLAG'="R") S DOADD=1
 . I DOADD D
 . . S OUT(IDX)=VPSTMP(I)
 . . S $P(OUT(IDX),U)=$P(OUT(IDX),U)_SORT
 . . I SORT="" S OUT(IDX)=$$ADDNAME(OUT(IDX))
 . . S IDX=IDX+1
 M RESULT=OUT
 Q
 ;
REMLIST(RESULT,DIV,SRV,LOC,UCL) ;Returns a list of all cover sheet reminders
 ;Input Parameter(s):
 ; DIV - Division Identifier
 ; SRV - Service Identifier
 ; LOC - Location Identifier
 ; UCL - List of User Classes separated by "^"
 ;Output Parameter(s):
 ; RESULT - Passed by reference, list of cover sheet reminders
 ; 
 N I,J,VPSLST,CODE,IDX,IEN,NEWP,VPSERR
 ;
 D NEWCVOK(.NEWP,DIV,SRV)
 I 'NEWP D GETLST^XPAR(.RESULT,"LOC.`"_+LOC_"^SRV.`"_+SRV_"^DIV.`"_+DIV_"^SYS^PKG","ORQQPX SEARCH ITEMS","Q",.VPSERR) Q
 D REMACCUM(.VPSLST,"PKG","Q",1000)
 D REMACCUM(.VPSLST,"SYS","Q",2000)
 I +DIV D REMACCUM(.VPSLST,"DIV.`"_+DIV,"Q",3000)
 I +SRV D REMACCUM(.VPSLST,"SRV.`"_+SRV,"Q",4000)
 I +LOC D REMACCUM(.VPSLST,"LOC.`"_+LOC,"Q",5000)
 I (UCL]"") D REMACCUM(.VPSLST,"CLASS","Q",6000,UCL)
 S I=0
 F  S I=$O(VPSLST(I)) Q:'I  D
 . S IDX=$P(VPSLST(I),U,1)
 . F  Q:'$D(RESULT(IDX))  S IDX=IDX+1
 . S CODE=$E($P(VPSLST(I),U,2),2)
 . S IEN=$E($P(VPSLST(I),U,2),3,999)
 . I CODE="R" D ADDREM(.RESULT,IDX,IEN)
 . I CODE="C" D ADDCAT(.RESULT,IDX,IEN)
 K RESULT("B")
 Q
 ;
ADDNAME(VPSX) ;Add Reminder or Category Name
 ;Input Parameter(s):
 ; VPSX - Reminder Info
 ;Output Parameter(s):
 ; VPSX - Add name as 3rd piece
 ;
 N CAT,IEN
 S CAT=$E($P(VPSX,U,2),2)
 S IEN=$E($P(VPSX,U,2),3,99)
 I +IEN D
 . I CAT="R" S $P(VPSX,U,3)=$$GET1^DIQ(811.9,IEN_",",1.2,"I") ;Print Name
 . I CAT="C" S $P(VPSX,U,3)=$$GET1^DIQ(811.7,IEN_",",.01,"I") ;Name
 Q VPSX
 ;
ADDREM(RESULT,IDX,IEN) ;Add Reminder to RESULT list, if applicable
 ;Input Parameter(s):
 ; IDX - External Reminder ID
 ; IEN - Internal Reminder ID
 ;Output Parameter(s):
 ; RESULT - Pass by reference, list of reminders
 ;
 Q:$G(IDX)=""
 Q:$G(IEN)=""
 N USAGE
 I $D(RESULT("B",IEN)) Q                    ; See if it's in the list
 I '$$FIND1^DIC(811.9,,,"`"_IEN) Q          ; Check if Exists
 I $$GET1^DIQ(811.9,IEN_",",1.6,"I")'="" Q  ; Check if Active
 ;check to see if the reminder is assigned to CPRS
 S USAGE=$$GET1^DIQ(811.9,IEN_",",103,"I")  ;Usage
 I USAGE["L" Q
 I USAGE'["C",USAGE'="*" Q
 S RESULT(IDX)=IDX_U_IEN
 S RESULT("B",IEN)=""
 Q
 ;
ADDCAT(RESULT,IDX,IEN) ;Add Reminders in a Category Reminder to RESULT list individually
 ;Input Parameter(s):
 ; IDX - External Category Reminder ID
 ; IEN - Internal Category Reminder ID
 ;Output Parameter(s):
 ; RESULT - Pass by reference, list of reminders
 ; 
 Q:$G(IDX)=""
 Q:$G(IEN)=""
 N REM,I,IDX2,NREM
 D CATREM^PXRMAPI0(IEN,.REM)
 S I=0
 F  S I=$O(REM(I)) Q:'I  D
 . S IDX2="00000"_I
 . S IDX2=$E(IDX2,$L(IDX2)-5,99)
 . D ADDREM(.RESULT,+(IDX_"."_IDX2),$P(REM(I),U,1))
 Q
 ;
NEWCVOK(RESULT,DIV,SRV) ; Checks if New or Old style Reminders are used
 ;Input Parameter(s):
 ; DIV - Division Identifier
 ; SRV - Service Identifier
 ;Output Parameter(s):
 ; RESULT - Passed by reference
 ; RESULT = 1 - if new style reminders
 ; RESULT = 0 - if old style reminders
 ; 
 N VPSERR,VPSTMP
 S RESULT=0
 D GETLST^XPAR(.VPSTMP,"SRV.`"_+$G(SRV)_"^DIV.`"_+$G(DIV)_"^SYS^PKG","ORQQPX NEW REMINDER PARAMS","Q",.VPSERR)
 I +VPSTMP S RESULT=$P($G(VPSTMP(1)),U,2)
 Q
