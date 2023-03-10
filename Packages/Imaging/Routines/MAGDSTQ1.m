MAGDSTQ1 ;WOIFO/PMK - Study Tracker - Query/Retrieve user ; Feb 15, 2022@10:52:44
 ;;3.0;IMAGING;**231,305**;Mar 19, 2002;Build 3
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; 
 ; Notice: This routine is on both VistA and the DICOM Gateway
 ;
 ;
 Q
 ;
PNAME ; get patient name attribute
 N HELP,PROMPT,X
 S PATLKUPMODE=$$GETMODE()
 I PATLKUPMODE="VISTA" D  ; routine for VistA
 . D PATIENTQ^MAGDSTQ7
 . Q
 E  D
 . S PROMPT="Enter the Patient Name"
 . S HELP(1)="Enter the Patient Name in ""LAST^FIRST^MIDDLE"" format"
 . S HELP(2)="You can enter a partial match and use ""*"" as a wild-card"
 . S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 . D CHKNAME(ATTRIB)
 . Q
 Q
 ;
CHKNAME(ATTRIB) ; convert comma(s) to caret(s) & remove leading spaces
 I $D(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB)) S ^(ATTRIB)=$TR(^(ATTRIB),",","^")
 ; remove any spaces before delimiters
 F  Q:$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB))'[" ^"  D
 . S ^(ATTRIB)=$P(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB)," ^",1)_"^"_$P(^(ATTRIB)," ^",2,999)
 . Q
 ; remove any spaces after delimiters
 F  Q:$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB))'["^ "  D
 . S ^(ATTRIB)=$P(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB),"^ ",1)_"^"_$P(^(ATTRIB),"^ ",2,999)
 . Q
 I $D(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB)) S ^(ATTRIB)=$TR(^(ATTRIB),",","^")
 Q
 ;
PID ; get patient id attribute
 N HELP,PROMPT,X
 S PATLKUPMODE=$$GETMODE()
 I PATLKUPMODE="VISTA" D  ; routine for VistA
 . D PATIENTQ^MAGDSTQ7
 . Q
 E  D
 . S PROMPT="Enter the Patient ID"
 . S HELP(1)="Enter the Patient ID (Social Security Number)"
 . S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 . Q
 Q
 ;
GETMODE() ; get the patient lookup CLIENT for manual Q/R client
 N HELP,X
 S PATLKUPMODE=$G(^TMP("MAG",$J,"Q/R PARAM","PATIENT LOOKUP MODE"),"<undef>")
 I PATLKUPMODE="<undef>" D
 . I '$$VISTA^MAGDSTQ,'$D(^TMP("MAG",$J,"DICOM RPC USER")) S PATLKUPMODE="MANUAL" Q  ; On gateway w/o RPCs
 . I $$YESNO^MAGDSTQ("Use VistA Patient identification information for PACS Query/Retrieve?","y",.X,.HELP)<0 Q:""
 . S PATLKUPMODE=$S(X="YES":"VISTA",1:"MANUAL")
 . S ^TMP("MAG",$J,"Q/R PARAM","PATIENT LOOKUP MODE")=PATLKUPMODE
 . I PATLKUPMODE="VISTA" D
 . . D ASKDASH^MAGDSTQ0
 . . Q
 . Q
 Q PATLKUPMODE
 ;
SEX ; get the patient's sex
 N HELP,PROMPT,X
 S PROMPT="Enter the sex of the patient"
 S HELP(1)="Enter M for male, F for female, or O for other."
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHECKSEX(.X)")
 Q
 ;
CHECKSEX(X) ;
 N RETURN,Y
 S RETURN=-1
 S X=$E(X) ; allow only a single uppercase letter
 X ^%ZOSF("UPPERCASE") S X=Y
 I "MFO"[X S RETURN=0
 Q RETURN
 ;
ACNUMB ; enter the accession number
 N ANPREFIX,HELP,PROMPT,X
 S PROMPT="Enter the Accession Number"
 S ANPREFIX=$G(^TMP("MAG",$J,"Q/R PARAM","ACCESSION NUMBER PREFIX"),"<undef>")
 I ANPREFIX'="<undef>",ANPREFIX'="" S PROMPT=PROMPT_" ("_ANPREFIX_")"
 S HELP(1)="For Radiology, the Accession Number is the Date-Case Number or Site-Date-Case Number."
 S HELP(2)="For CPRS Requests, it is ""GMRC-"" followed by the request number, or"
 S HELP(3)="Site-GMR-Request Number, where Site is the station number."
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 I "@^"'[X S X=$$ANPREFIX
 Q
 ;
ANPREFIX() ; add the site-specific accession number prefix
 N ANPREFIX,RETURN
 I $L(X,"-")=3 S RETURN=0 ; <station name> - MMDDYY - <case number>
 E  D
 . S ANPREFIX=$G(^TMP("MAG",$J,"Q/R PARAM","ACCESSION NUMBER PREFIX"),"<undef>")
 . I ANPREFIX="<undef>" D
 . . I $$VISTA^MAGDSTQ D  ; VistA code - call API
 . . . S ANPREFIX=$$ANPREFIX^MAGDSTAB
 . . . Q
 . . E  D  ; DICOM Gateway code - call RPC
 . . . N RPCERR
 . . . I '$D(^TMP("MAG",$J,"DICOM RPC USER")) D  Q  ; no RPC
 . . . . S ANPREFIX=""
 . . . . Q
 . . . S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM GET ACN PREFIX","M",.ANPREFIX)
 . . . I RPCERR<0 D  S OUTPUT(0)=-1 Q
 . . . . D ERRORMSG^MAGDSTQ0(1,"Error in MAG DICOM GET ACN PREFIX rpc",.ANPREFIX)
 . . . . Q
 . . . Q
 . . S ANPREFIX=$$GETANPFX(ANPREFIX) ; allow the accession number prefix to be changed
 . . S ^TMP("MAG",$J,"Q/R PARAM","ACCESSION NUMBER PREFIX")=ANPREFIX
 . . Q
 . S RETURN=1
 . I $D(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB)) S ^(ATTRIB)=ANPREFIX_^(ATTRIB)
 . Q
 Q RETURN
 ;
GETANPFX(DEFAULT) ; get the accession number prefix
 N ANPREFIX,OK
 S OK=0 F  D  Q:OK
 . W !!,"Enter the Accession Number Prefix: "
 . I $L(DEFAULT) W DEFAULT,"// "
 . R ANPREFIX:DTIME E  S OK=-1 Q
 . I ANPREFIX="",$L(DEFAULT) S ANPREFIX=DEFAULT W ANPREFIX
 . I ANPREFIX="" W " -- use ""@"" to remove it" Q
 . I ANPREFIX["^" S OK=-1 Q
 . I ANPREFIX="@" S ANPREFIX=""
 . I ANPREFIX?0.4(1U,1N,1"-") S OK=1
 . E  W "  ???",!,"Please enter ""@"" or 1-4 characters (numeric, uppercase characters, hyphen)"
 . Q
 Q ANPREFIX
 ;
REFDOC ;
 N HELP,PROMPT,X
 S PROMPT="Enter the Referring Physician's name"
 S HELP(1)="Enter the Referring Physician's name in ""LAST^FIRST^MI"" format"
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 D CHKNAME(ATTRIB)
 Q
 ;
STUDYID ; enter the study id
 N HELP,PROMPT,X
 S PROMPT="Enter the Study Identifier"
 S HELP(1)="The Study Identifier is generated by the modality."
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 Q
 ;
SERIESNO ; enter the series number
 N HELP,PROMPT,X
 S PROMPT="Enter the Series Number"
 S HELP(1)="The Study Number is generated by the modality."
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 Q
 ;
REQPROID ; enter the requested procedure id
 N HELP,PROMPT,X
 S PROMPT="Enter the Requested Procedure ID"
 S HELP(1)="The Requested Procedure ID is generated by VistA."
 S HELP(2)="For Radiology, it is Case Number."
 S HELP(3)="For CPRS requests, it is the consult or procedure number."
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 Q
 ;
SPSTEPID ; enter the scheduled procedure step id
 N HELP,PROMPT,X
 S PROMPT="Enter the Scheduled Procedure Step ID"
 S HELP(1)="The studies generated by VistA, it is the Accession Number."
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP)
 Q
 ;
STUDYUID ; enter the study instance uid
 N HELP,PROMPT,X
 S PROMPT="Enter the Study Instance UID"
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHECKUID(.X)")
 Q
 ;
SERIEUID ; enter the series instance uid
 N HELP,PROMPT,X
 S PROMPT="Enter the Series Instance UID"
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHECKUID(.X)")
 Q
 ;
SOPUID ; enter the SOP instance uid
 N HELP,PROMPT,X
 S PROMPT="Enter the SOP Instance UID"
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHECKUID(.X)")
 Q
 ;
CHECKUID(X) ; check the format of the uid
 N RETURN
 S RETURN=-1
 I X?.(1N.N1".")1N.N S RETURN=0
 Q RETURN
 ;
MODALITY ; select the modality
 N HELP,PROMPT,X
 S PROMPT="Enter the Modality Code"
 S HELP(1)="Please enter the DICOM modality value"
 S HELP(2)="Examples: CR, CT, DX, MR, NM, RF, US, XA"
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHECKMOD(.X)")
 Q
 ;
CHECKMOD(X) ; check the validity of the entered modality value
 N DICTIEN,MODALIEN,RETURN,Y
 X ^%ZOSF("UPPERCASE") S X=Y
 I X="" S RETURN=0
 E  I $$VISTA^MAGDSTQ D
 . S RETURN=0 ; can't check on VistA
 . Q
 E  D
 . S DICTIEN=$O(^MAGDICOM(2006.51,"B","0008,0060",""))
 . I 'DICTIEN D
 . . W !!,"Please run the menu option to Reinitialize All the DICOM Master Files",!
 . . S RETURN=-1
 . . Q
 . E  S MODALIEN=$O(^MAGDICOM(2006.51,DICTIEN,1,"B",X,"")) I 'MODALIEN D
 . . W !,"*** Warning: Modality """,X,""" is not defined in DICOM."
 . . S RETURN=-1
 . . Q
 . E  D
 . . W " -- ",$P($P(^MAGDICOM(2006.51,DICTIEN,1,MODALIEN,0),"^",2),"=",1)
 . . R Y:5
 . . S RETURN=0
 . . Q
 . Q
 Q RETURN
 ;
BIRTHDAT ; birth date, may be a range
 D GETDATE("B")
 Q
 ;
STDYDATE ; study date, may be a range
 D GETDATE("S")
 Q
 ;
GETDATE(TYPE) ; get the date
 N HELP,PROMPT,X
 S PROMPT=$S(TYPE="B":"Birth",1:"Study")_" Date (yyyymmdd or yyyymmdd-yyyymmdd)"
 S HELP(1)="The "_$S(TYPE="B":"birth",1:"study")_" date can be entered in several formats:"
 S HELP(2)="   1)  yyyymmdd  (selects only one date)"
 S HELP(3)="   2)  yyyymmdd- (selects that date and subsequent ones)"
 S HELP(4)="   3) -yyyymmdd  (selects that date and prior ones)"
 S HELP(5)="   4)  yyyymmdd-yyyymmdd (selects an inclusive range of dates)"
 S HELP(6)="   5)  FileMan ""T..."" dates are accepted and converted to yyyymmdd"
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHKDATE(.X)")
 Q
 ;
CHKDATE(X) ; check the date
 I (X?1"T".E)!(X="NOW") D
 . N %DT
 . S %DT="TS" D ^%DT
 . S X=Y\1,$E(X)=$E(X)+17
 . Q
 Q $S(X="":0,X?8N:0,X?8N1"-":0,X?1"-"8N:0,X?8N1"-"8N:0,1:-1)
 ;
STDYTIME ; study time, may be a range
 N HELP,PROMPT,X
 S PROMPT="Study Time (hhmmss or hhmmss-hhmmss)"
 S HELP(1)="The study time can be entered in several formats:"
 S HELP(2)="   1)  hhmmss  (selects only one time - not too useful!)"
 S HELP(3)="   2)  hhmmss- (selects that time and subsequent ones)"
 S HELP(4)="   3) -hhmmss  (selects that time and prior ones)"
 S HELP(5)="   4)  hhmmss-hhmmss (selects an inclusive range of times)"
 S HELP(6)="Note: all times are 24-hour"
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHKTIME(.X)")
 Q
 ;
CHKTIME(X) ; check the study time
 Q $S(X="":0,X?6N:0,X?6N1"-":0,X?1"-"6N:0,X?6N1"-"6N:0,1:-1)
 ;
QRROOT ; get query/retrieve root
 N HELP,PROMPT,X
 S PROMPT="Query/Retrieve Root (Patient or Study)"
 S HELP(1)="The Query/Retrieve Root determines the DICOM information model for the query."
 S HELP(2)=""
 S HELP(3)="The Patient Root has four levels: Patient, Study, Series, and Image."
 S HELP(4)=""
 S HELP(5)="The Study Root Information Model has three levels: Study, Series, and Image,"
 S HELP(6)="with the Patient Level information included in the Study Level."
 S HELP(7)=""
 S HELP(8)="If you are only looking for a single study and know the accession number, the"
 S HELP(9)="STUDY Root will allow you search by accession number and find it quickest."
 S HELP(10)=""
 S HELP(11)="If you are looking for all the studies for a patient, use the PATIENT Root."
 S X=$$GETKEY(ATTRIB,PROMPT,.HELP,"$$CHKQRR(.X)")
 Q
 ;
CHKQRR(X) ; check the query/retrieve root
 N ERROR,Y,Z S ERROR=1
 X ^%ZOSF("UPPERCASE") S X=Y
 I $E(X)="P" S X="PATIENT",ERROR=0
 E  I $E(X)="S" D
 . S X="STUDY",ERROR=0
 . I $G(^TMP("MAG",$J,"Q/R PARAM","QUERY LEVEL"))="PATIENT" D
 . . W !,"Patient Level queries are not supported for Study Root -- changing to STUDY"
 . . R Z:5
 . . S ^TMP("MAG",$J,"Q/R PARAM","QUERY LEVEL")="STUDY"
 . . Q
 . Q
 Q ERROR
 ;
GETKEY(ATTRIB,PROMPT,HELP,CHECK) ; get the value for the key
 N DONE,DEFAULT,I,X
 S DEFAULT=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB))
 S DONE="" F  D  Q:DONE
 . W !!,PROMPT,":  " I DEFAULT'="" W DEFAULT,"// "
 . R X:DTIME I X="" S X=DEFAULT W X
 . I X["?" D
 . . W ! S I=0 F  S I=$O(HELP(I)) Q:'I  W !,HELP(I)
 . . I DEFAULT'="" W !!,"(Enter ""@"" to delete the """,DEFAULT,""" value)"
 . . Q
 . E  S DONE=1 I X'="^" D  ; a caret will terminate the program
 . . I X="@" D
 . . . K ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB) W " -- deleted"
 . . . I ATTRIB?1"PATIENT".E K ^TMP("MAG",$J,"Q/R PARAM","PATIENT LOOKUP MODE") ; reset VistA/Manual Mode
 . . . Q
 . . E  D
 . . . I $D(CHECK),@CHECK D  W "Illegal Value" S DONE=0
 . . . . I $X>60 W !
 . . . . E  W "  "
 . . . . Q
 . . . E  S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB)=X
 . . . Q
 . . Q
 . Q
 Q X
