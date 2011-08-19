EASEZU2 ;ALB/jap - Utilities for 1010EZ Processing ;10/13/00  10:53
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**53,70**;Mar 15, 2001;Build 26
 ;
PICKALL(EASVIEW) ;For processing status selected, pick-up all records in #712
 ;Loop through Application Holding file #712 for status selected
 N APP,FAC,INDEX,JDATE,DAT0,NAME,SSN,VETTYPE,FDAYS,WEBID,WILLSEND,ENTRY,EDATE,X,Y,I,J,T,V,X1,X2,X3
 Q:'EASVIEW  Q:EASVIEW>6
 K ^TMP($J,712,EASVIEW)
 ;index to search depends on status selected for viewing
 S V=EASVIEW,INDEX=$S(V=1:"NEW",V=2:"REV",V=3:"PRT",V=4:"SIG",V=5:"FIL",V=6:"CLS",1:"")
 Q:V=""  Q:INDEX=""
 S I=INDEX D
 . ;use the index to get each application in selected status
 . ;here JDATE is the date on which the application reached status of interest
 . S JDATE=0 F  S JDATE=$O(^EAS(712,I,JDATE)) Q:'JDATE  S APP=0 F  S APP=$O(^EAS(712,I,JDATE,APP)) Q:'APP  D
 . . S DAT0=$G(^EAS(712,APP,0)),NAME=$P(DAT0,U,4),ENTRY=$P(DAT0,U,6),SSN=$P($P(DAT0,U,5),"&",1),T=$P(DAT0,U,9)
 . . S WEBID=$P(DAT0,U,2),WILLSEND=$P(DAT0,U,13)
 . . S FAC=$P($G(^EAS(712,APP,1)),U,6) S:FAC="" FAC=1
 . . ;don't include filed apps if filed more than 30 days ago. 
 . . S FDAYS=0 I (INDEX="FIL")!(INDEX="CLS") S X2=JDATE,X1=DT D ^%DTC S FDAYS=X
 . . I FDAYS>30 K ^EAS(712,INDEX,JDATE,APP)
 . . Q:FDAYS>30
 . . ;avoid any stub entries
 . . Q:NAME=""
 . . S Y=ENTRY,%F=2,EDATE=$$FMTE^XLFDT(Y,%F) I $L(EDATE)<10 D
 . . . S X1=$P(EDATE,"/",1),X2=$P(EDATE,"/",2),X3=$P(EDATE,"/",3)
 . . . S:$L(X1)=1 X1="0"_X1 S:$L(X2)=1 X2="0"_X2
 . . . S EDATE=X1_"/"_X2_"/"_X3
 . . S VETTYPE=$S(T=1:"SC 50-100%",T=2:"SC <50%",T=3:"SC 0%",T=4:"POW",T=5:"PURPLE HEART",T=6:"MIL. RETIREE",T=7:"NSC",1:"")
 . . S ^TMP($J,712,EASVIEW,FAC,NAME,ENTRY,APP)=APP_U_SSN_U_VETTYPE_U_EDATE_U_JDATE_U_WEBID_U_WILLSEND_U_FAC
 Q
 ;
SETDATE(EASAPP,INDEX) ;update fields & indexes associated with processing status
 ;
 N DA,DR,DIE
 S DA=EASAPP,DIE="^EAS(712,"
 I INDEX="REV" S DR="5.1///^S X=DT;5.2////^S X=DUZ" D ^DIE,REINDEX^EASEZU2(EASAPP,INDEX) Q
 I INDEX="PRT" S DR="6.1///^S X=DT;6.2////^S X=DUZ" D ^DIE,REINDEX^EASEZU2(EASAPP,INDEX) Q
 I INDEX="SIG" S DR="4///^S X=DT;4.1///^S X=DT;4.2////^S X=DUZ" D ^DIE,REINDEX^EASEZU2(EASAPP,INDEX) Q
 I INDEX="FIL" S DR="7.1///^S X=DT;7.2////^S X=DUZ" D ^DIE,REINDEX^EASEZU2(EASAPP,INDEX) Q
 I INDEX="CLS" S DR="9.1///^S X=DT;9.2////^S X=DUZ" D ^DIE,REINDEX^EASEZU2(EASAPP,INDEX) Q
 Q
 ;
APPINDEX(EASAPP) ;Check file #712 processing index for Application
 ;get determining date and remove any index entries no longer current
 N CLSDATE,FILDATE,SIGDATE,PRTDATE,REVDATE,NEWDATE
 S CLSDATE=$P($G(^EAS(712,EASAPP,2)),U,9) I CLSDATE D REINDEX(EASAPP,"CLS",CLSDATE) Q
 S FILDATE=$P($G(^EAS(712,EASAPP,2)),U,5) I FILDATE D REINDEX(EASAPP,"FIL",FILDATE) Q
 S SIGDATE=$P($G(^EAS(712,EASAPP,1)),U,1) I SIGDATE D REINDEX(EASAPP,"SIG",SIGDATE) Q
 S PRTDATE=$P($G(^EAS(712,EASAPP,2)),U,3) I PRTDATE D REINDEX(EASAPP,"PRT",PRTDATE) Q
 S REVDATE=$P($G(^EAS(712,EASAPP,2)),U,1) I REVDATE D REINDEX(EASAPP,"REV",REVDATE) Q
 S NEWDATE=$P($G(^EAS(712,EASAPP,0)),U,6) I NEWDATE D REINDEX(EASAPP,"NEW",NEWDATE) Q
 Q
 ;
REINDEX(EASAPP,EASINDEX,THISDATE) ;Remove previous index for Application upon processing status change
 ;There are 6 critical indexes maintained on file #712 to indicate processing status.
 ;   "NEW" -- New applications; uses field #3, ENTRY DATE
 ;   "REV" -- In Review applications; uses field #5.1, REVIEW DATE
 ;   "PRT" -- Printed/Awaiting Signature applications; uses field #6.1, PRINT DATE
 ;   "SIG" -- Signed applications; uses field #4, DATE SIGNED BY APPLICANT
 ;   "FIL" -- Filed applications; uses field #7.1, FILING DATE
 ;   "CLS" -- Closed/inactivated applications; uses field #9.1, CLOSE DATE
 ;
 ;When a date is initially entered into one of the fields listed above, FM updates the
 ;   the index as needed; this function removes the "old" index entry for the application.
 ;
 ;Once a date has been entered into one of the fields listed above, repeated actions
 ;   of the same type do not update the field with a new date; therefore, a new index
 ;   entry won't be created.
 ;   For example: The first time the 1010EZ application is Printed for Signature
 ;                field #6.1 is updated and FM creates the index entry in "PRT",
 ;                and this function is called to remove the old "REV" index entry;
 ;                If the 1010EZ is Printed again sometime later, say after it has
 ;                already been Filed, that Print action will not update field #6.1
 ;
 ;input 
 ;   EASAPP   = ien in file #712 for Application
 ;   EASINDEX = index for current processing status
 ;   THISDATE = date to be used to set cross-reference; [optional]
 ;              internal FM format
 ;output
 ;   none
 ;
 N DATE
 ;
 ;set appropriate index if necessary
 I $G(THISDATE) S ^EAS(712,EASINDEX,THISDATE,EASAPP)=""
 ;
 I EASINDEX="NEW" D  Q
 . ;get REVIEW DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,1)
 . I DATE K ^EAS(712,"REV",DATE,EASAPP)
 . ;get PRINT DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,3)
 . I DATE K ^EAS(712,"PRT",DATE,EASAPP)
 ;
 I EASINDEX="REV" D  Q
 . ;get ENTRY DATE
 . S DATE=$P($G(^EAS(712,EASAPP,0)),U,6)
 . I DATE K ^EAS(712,"NEW",DATE,EASAPP)
 ;
 I EASINDEX="PRT" D  Q
 . ;get REVIEW DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,1)
 . I DATE K ^EAS(712,"REV",DATE,EASAPP)
 ;
 I EASINDEX="SIG" D  Q
 . ;get REVIEW DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,1)
 . I DATE K ^EAS(712,"REV",DATE,EASAPP)
 . ;get PRINT DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,3)
 . I DATE K ^EAS(712,"PRT",DATE,EASAPP)
 ;
 I EASINDEX="FIL" D  Q
 . ;get PRINT DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,3)
 . I DATE K ^EAS(712,"PRT",DATE,EASAPP)
 . ;get DATE SIGNED BY APPLICANT
 . S DATE=$P($G(^EAS(712,EASAPP,1)),U,1)
 . I DATE K ^EAS(712,"SIG",DATE,EASAPP)
 ;
 I EASINDEX="CLS" D  Q
 . ;get ENTRY DATE
 . S DATE=$P($G(^EAS(712,EASAPP,0)),U,6)
 . I DATE K ^EAS(712,"NEW",DATE,EASAPP)
 . ;get REVIEW DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,1)
 . I DATE K ^EAS(712,"REV",DATE,EASAPP)
 . ;get PRINT DATE
 . S DATE=$P($G(^EAS(712,EASAPP,2)),U,3)
 . I DATE K ^EAS(712,"PRT",DATE,EASAPP)
 ;
 Q
 ;
CURRSTAT(EASAPP) ;Check file #712 processing index for Application
 ;return current Application status
 N CLSDATE,FILDATE,SIGDATE,PRTDATE,REVDATE,NEWDATE
 S CLSDATE=$P($G(^EAS(712,EASAPP,2)),U,9) I CLSDATE Q "CLS"
 S FILDATE=$P($G(^EAS(712,EASAPP,2)),U,5) I FILDATE Q "FIL"
 S SIGDATE=$P($G(^EAS(712,EASAPP,1)),U,1) I SIGDATE Q "SIG"
 S PRTDATE=$P($G(^EAS(712,EASAPP,2)),U,3) I PRTDATE Q "PRT"
 S REVDATE=$P($G(^EAS(712,EASAPP,2)),U,1) I REVDATE Q "REV"
 S NEWDATE=$P($G(^EAS(712,EASAPP,0)),U,6) I NEWDATE Q "NEW"
 Q ""
 ;
LOCAL711 ;set up TMP global array
 ;to hold file #711 & file #712 correlated data; and a useful index
 N IEN,DIC,DIE,DA,DR,DLAYGO,DINUM,X,Y,DATANM,DATAKEY,DISPNM,FILE,SUBF,FLD,GRP
 ;make sure 'unknown' is in #711
 K ^TMP("EZDATA",$J),^TMP("EZINDEX",$J)
 I '$D(^EAS(711,.1,0)) D
 . S DIC="^EAS(711,",DIC(0)="L",DLAYGO="",X="UNKNOWN",DINUM=.1
 . K DD,DO D FILE^DICN
 I $D(^EAS(711,.1,0)) D
 . S DA=.1
 . S DIE="^EAS(711,",DR=".1///^S X=""UNKNOWN"";1///^S X=""A"";2///^S X=0;3///^S X=0;4///^S X=0"
 . D ^DIE
 ;pick up records from "ACTIVE" index
 S IEN=0 F  S IEN=$O(^EAS(711,"A","A",IEN)) Q:'IEN  D
 . S DATAKEY=$P(^EAS(711,IEN,0),U,2),X=$G(^EAS(711,IEN,1)),FILE=$P(X,U,1),SUBF=$P(X,U,2),FLD=$P(X,U,3) S:SUBF="" SUBF=FILE
 . S DATANM=$P($G(^EAS(711,IEN,0)),U,1),DISPNM=$G(^EAS(711,IEN,2))
 . S ^TMP("EZDATA",$J,IEN)=X_U_DATAKEY_U_DISPNM
 . ;EAS*1.0*70
 . S GRP=$S(DATANM["SPOUSE":"S",DATANM["CHILD1":"C1",DATANM["CHILD(N)":"CN",DATANM["ASSET(N)":"CN",1:"A")
 . I DATANM["ASSET(N)" S ^TMP("EZINDEX",$J,"C1",FILE,SUBF,FLD,IEN)=IEN_U_DATANM
 . S ^TMP("EZINDEX",$J,GRP,FILE,SUBF,FLD,IEN)=IEN_U_DATANM
 Q
