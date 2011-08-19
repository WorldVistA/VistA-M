PRSDSTAT ;HISC/GWB-PAID DOWNLOAD STATISTICS GENERATOR ;02/20/03
 ;;4.0;PAID;**28,78**;Sep 21, 1995
 S ^TMP($J,"PRSD",1)="Download statistics for station "_STA_" for "_$E(DATE,5,6)_"/"_$E(DATE,7,8)_"/"_$E(DATE,3,4)_":"
 S ^TMP($J,"PRSD",2)=" "
 S ^TMP($J,"PRSD",3)="Download type: "_MTYPE
 S ^TMP($J,"PRSD",4)=$S(TYPE="P":"Pay Period:    "_PP,1:" ")
 S ^TMP($J,"PRSD",5)="Number of employees processed: "_ECNT
 S ^TMP($J,"PRSD",6)=" "
 S ^TMP($J,"PRSD",8)=" "
 S (ERRCNT,ERRIEN)=0,ERRID=TYPE_"-"_DATE_"-"_STA,SUBS=9
 F EE=1:1 S ERRIEN=$O(^PRSD(450.11,"B",ERRID,ERRIEN)) Q:ERRIEN'>0  D ERRS
 I ERRCNT=0 S ^TMP($J,"PRSD",7)="There were no processing errors."
 I ERRCNT>0 S ^TMP($J,"PRSD",7)="The following errors were encountered:"
 I TYPE="D" S ^TMP($J,"PRSD",SUBS)="The following employees were separated in the previous pay period:" D ADLIST
 I (TYPE="E")!(TYPE="I"),$D(^TMP($J,"PRS")) S ^TMP($J,"PRSD",SUBS)="The following employees have been added to the PAID EMPLOYEE file:" D ADLIST
 I TYPE="E",$D(^TMP($J,"PRSNC")) S ^TMP($J,"PRSD",SUBS)="The following employees' names have been changed in the PAID EMPLOYEE file:" D NCLIST
 I TYPE="T",$D(^TMP($J,"PRS")) S ^TMP($J,"PRSD",SUBS)="The following employees are transfers to your station or SSN changes:" D ADLIST
 I (TYPE="E")!(TYPE="I")!(TYPE="T"),$D(^TMP($J,"ORG")) S SUBS=SUBS+1 S ^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)="The following cost center/organizations were added to the PAID CODE FILES file:" D ORGLIST
 S XMY("G.PAD@"_^XMB("NETNAME"))=""
 S XMDUZ=.5,XMSUB="PAID "_MTYPE_" statistics "_$E(DATE,5,6)_"/"_$E(DATE,7,8)_"/"_$E(DATE,3,4),XMTEXT="^TMP($J,""PRSD""," D ^XMD
 K ^TMP($J),SUBS
DELMSG ;D NOW^%DTC S DT=X
 ;S MBIEN=0,MBIEN=$O(^XMB(3.7,.5,2,"B","S.PRSD",MBIEN))
 ;S MMIEN=0 F  S MMIEN=$O(^XMB(3.7,.5,2,MBIEN,1,MMIEN)) Q:MMIEN'>0  D
 ;.I '$D(^XMB(3.9,MMIEN)) S XMSER="S.PRSD",XMZ=MMIEN D REMSBMSG^XMA1C Q
 ;.S X=$P(^XMB(3.9,MMIEN,0),U,3),X=$P(X," ",1)_$P(X," ",2)_$P(X," ",3) D ^%DT I Y'=-1 S X1=DT,X2=Y D ^%DTC I X>90 S XMSER="S.PRSD",XMZ=MMIEN D REMSBMSG^XMA1C
 K MBIEN,MMIEN,X,Y,XMSER,NOS,SPACES
 Q
ERRS S ERRMSG=$P(^PRSD(450.11,ERRIEN,0),U,3)
 S ^TMP($J,"PRSD",SUBS)=ERRMSG,SUBS=SUBS+1
 S ^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1
 I ERRMSG'["Unable to add",ERRMSG'["already used by" S ERRCNT=ERRCNT+1
 S DIK="^PRSD(450.11,",DA=ERRIEN D ^DIK
 K ERRMSG Q
ADLIST S NAME="" F  S NAME=$O(^TMP($J,"PRS",NAME)) Q:NAME=""  S SSN="" F  S SSN=$O(^TMP($J,"PRS",NAME,SSN)) Q:SSN=""  D
 .S SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1
 .S SPACES="" S NOS=27-$L(NAME),$P(SPACES," ",NOS)=" "
 .S ^TMP($J,"PRSD",SUBS)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_"  "_NAME_SPACES_$P(^TMP($J,"PRS",NAME,SSN),U,1)_"  "_$P(^TMP($J,"PRS",NAME,SSN),U,2)
 S SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1
 I $D(^TMP($J,"PRSNP")) D
 .S ^TMP($J,"PRSD",SUBS)="The following employees' SSNs could not be found in the NEW PERSON file."
 .S SUBS=SUBS+1
 .S ^TMP($J,"PRSD",SUBS)="They may need:"
 .S SUBS=SUBS+1
 .S ^TMP($J,"PRSD",SUBS)="1) To be added to the NEW PERSON file,"
 .S SUBS=SUBS+1
 .S ^TMP($J,"PRSD",SUBS)="2) To have their SSNs added to the NEW PERSON file,"
 .S SUBS=SUBS+1
 .S ^TMP($J,"PRSD",SUBS)="3) To have their SSNs corrected in the NEW PERSON file or"
 .S SUBS=SUBS+1
 .S ^TMP($J,"PRSD",SUBS)="4) To have their SSNs corrected (via OLDE) in the PAID EMPLOYEE file."
 .S SUBS=SUBS+1
 .S ^TMP($J,"PRSD",SUBS)="Please notify or forward this message to your IRM representative."
 .S NAME="" F  S NAME=$O(^TMP($J,"PRSNP",NAME)) Q:NAME=""  S SSN="" F  S SSN=$O(^TMP($J,"PRSNP",NAME,SSN)) Q:SSN=""  D
 ..S SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1
 ..S ^TMP($J,"PRSD",SUBS)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_"  "_NAME
 S SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1
 Q
NCLIST S NAME=""
 F  S NAME=$O(^TMP($J,"PRSNC",NAME)) Q:NAME=""  S SSN="" F  S SSN=$O(^TMP($J,"PRSNC",NAME,SSN)) Q:SSN=""  D
 .S SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1
 .S SPACES="" S NOS=27-$L(NAME),$P(SPACES," ",NOS)=" "
 .S ^TMP($J,"PRSD",SUBS)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_"  "_NAME_SPACES_$P(^TMP($J,"PRSNC",NAME,SSN),U,1)
 S SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)=" "
 Q
ORGLIST S NAME=""
 F  S NAME=$O(^TMP($J,"ORG",NAME)) Q:NAME=""  S SUBS=SUBS+1 S ^TMP($J,"PRSD",SUBS)=" ",SUBS=SUBS+1,^TMP($J,"PRSD",SUBS)=NAME
 Q
