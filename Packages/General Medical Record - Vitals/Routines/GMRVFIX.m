GMRVFIX ;HIOFO/FT-CONVERT C TEMPERATURES TO F, THEN REPLACE ;3/12/04  09:50
 ;;4.0;Vitals/Measurements;**16**;Apr 25, 1997
 ;
 ; This routine uses the following IAs:
 ; #2320  - ^%ZISH calls           (supported)
 ; #10063 - ^%ZTLOAD calls         (supported)
 ; #10070 - ^XMD calls             (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
EN ; Main entry point
 D QUEUE
 Q
QUEUE ; Queue the clean-up
 N ZTDESC,ZTDTH,ZTRTN,ZTIO,ZTSAVE,ZTSK
 S ZTRTN="START^GMRVFIX",ZTIO=""
 S ZTDTH=$$NOW^XLFDT(),ZTDESC="GMRV*4*16 DATA REPAIR"
 D ^%ZTLOAD
 I ZTSK>0 D
 .D EN^DDIOL("Task "_ZTSK_" has started. I'll send you a MailMan message when I finish.","","!?5")
 .Q
 I ZTSK'>0 D
 .S GMRVMSG="I couldn't start the task to repair the data."
 .D EN^DDIOL(GMRVMSG,"","!?5")
 .D ERRMAIL(GMRVMSG)
 .Q 
 Q
START ; Start looping through the database
 I $D(ZTQUEUED) S ZTREQ="@"
 N GMRVCNT,GMRVFILE,GMRVFIXD,GMRVIEN,GMRVLINE,GMRVLOOP,GMRVMSG,GMRVNEW,GMRVNODE,GMRVPATH,GMRVOLD,GMRVOUT,GMRVSTOP,GMRVTEMP,GMRVTMP,GMRVTOTL
 N POP
 ; get TEMPERATURE ien
 S GMRVTEMP=$O(^GMRD(120.51,"C","T",0))
 I GMRVTEMP'>0 D  Q
 .S GMRVMSG="Can't find TEMPERATURE in the VITAL types file (120.5). Please log a NOIS."
 .D ERRMAIL(GMRVMSG)
 .Q
 ;
 S GMRVTMP(1)="The following TEMPERATURE readings in the GMRV VITAL MEASUREMENT (#120.5)"
 S GMRVTMP(2)="file were modified. The old value was a number less than 45. It was assumed"
 S GMRVTMP(3)="that the reading was done in Celsius units but not converted to Fahrenheit"
 S GMRVTMP(4)="before being stored in the database. These entries have now been converted"
 S GMRVTMP(5)="to Fahrenheit and saved. IEN indicates the record number in FILE 120.5."
 S GMRVTMP(6)="OLD indicates the previous value and NEW indicates the new value."
 S GMRVTMP(7)=" "
 ; set host file name and directory path
 S GMRVFILE="GMRV_4_16.DAT"
 S GMRVPATH=$$PWD^%ZISH ;current directory
 ; Open up device to print to
 D OPEN^%ZISH("VITAL",GMRVPATH,GMRVFILE,"A") ;'A' for append
 I POP D  Q  ;send email if device cannot be opened
 .S GMRVMSG="Could not open file "_GMRVFILE_" in path "_GMRVPATH_"."
 .D ERRMAIL(GMRVMSG)
 .Q
 U IO
 ; from this point on, the Write commands are writing to the host file.
 F GMRVLOOP=1:1:7 W !,GMRVTMP(GMRVLOOP)
 S (GMRVFIXD,GMRVIEN,GMRVOUT,GMRVSTOP,GMRVTOTL)=0,GMRVCNT=7
 F  S GMRVIEN=$O(^GMR(120.5,"T",GMRVTEMP,GMRVIEN)) Q:'GMRVIEN!(GMRVOUT=1)  D
 .S GMRVSTOP=GMRVSTOP+1,GMRVTOTL=GMRVTOTL+1
 .I GMRVSTOP=1000 D  Q:GMRVOUT=1  ;check if the user stopped the task
 ..S GMRVSTOP=0
 ..I $$S^%ZTLOAD  D
 ...S GMRVOUT=1
 ...S GMRVMSG="Job stopped by user while checking entry # "_GMRVIEN
 ...W !,GMRVMSG
 ...D ERRMAIL(GMRVMSG)
 ...Q
 ..Q
 .Q:$P($G(^GMR(120.5,GMRVIEN,2)),U,1)=1  ;entered-in-error
 .S GMRVNODE=$G(^GMR(120.5,GMRVIEN,0))
 .Q:GMRVNODE=""
 .Q:$P(GMRVNODE,U,3)'=GMRVTEMP  ;not a temperature
 .Q:+$P(GMRVNODE,U,8)'>0  ;not a numeric reading
 .I +$P(GMRVNODE,U,8)>45!(+$P(GMRVNODE,U,8)=45) Q  ;not celsius value
 .S GMRVOLD=$P(GMRVNODE,U,8)
 .S GMRVNEW=(+$P(GMRVNODE,U,8)*1.8)+32
 .S GMRVNEW=$$ROUND(GMRVNEW) ;round to 2 decimal places
 .S $P(^GMR(120.5,GMRVIEN,0),U,8)=GMRVNEW
 .S GMRVFIXD=GMRVFIXD+1
 .S GMRVLINE="IEN="_GMRVIEN_"    "_"OLD="_GMRVOLD_" / "_"NEW="_GMRVNEW
 .W !,GMRVLINE
 .Q
 I GMRVFIXD'>0 D
 .S GMRVCNT=GMRVCNT+1
 .S GMRVTMP(GMRVCNT)="No entries needed to be changed."
 .W !,GMRVTMP(GMRVCNT)
 .Q
 S GMRVCNT=GMRVCNT+1
 S GMRVTMP(GMRVCNT)=" "
 W !,GMRVTMP(GMRVCNT)
 S GMRVCNT=GMRVCNT+1
 S GMRVTMP(GMRVCNT)="Total number of entries checked: "_GMRVTOTL
 W !,GMRVTMP(GMRVCNT)
 S GMRVCNT=GMRVCNT+1
 S GMRVTMP(GMRVCNT)="Number of entries fixed: "_GMRVFIXD
 W !,GMRVTMP(GMRVCNT)
 S GMRVCNT=GMRVCNT+1
 S GMRVTMP(GMRVCNT)=GMRVFILE_" in path "_GMRVPATH_" contains a listing of entries changed."
 W !,GMRVTMP(GMRVCNT)
 D CLOSE^%ZISH("VITAL")
 K GMRVTMP
 S GMRVTMP(1)="The GMRV*4*16 data repair is finished."
 S GMRVTMP(2)=" "
 S GMRVTMP(3)="Total number of entries checked: "_GMRVTOTL
 S GMRVTMP(4)="        Number of entries fixed: "_GMRVFIXD
 S GMRVTMP(5)=" "
 S GMRVTMP(6)="The "_GMRVFILE_" file in the "_GMRVPATH_" directory"
 S GMRVTMP(7)="contains a listing of entries changed."
 D EMAIL(.GMRVTMP)
 K GMRVFILE,GMRVPATH
 Q
EMAIL(GMRVTMP) ; send Mailman message when job is done
 ; Input
 ;  GMRVTMP is message text
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="GMRV*4*16 DATA REPAIR"
 S XMY(DUZ)="",XMDUZ=.5
 S XMTEXT="GMRVTMP("
 D ^XMD
 Q
ERRMAIL(GMRVMSG) ; Send email with error message
 ; Input
 ;   GMRVMSG is error message text
 N DIFROM,GMRVTEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="Error with GMRV*4*16 Post-Installation"
 S XMY(DUZ)="",XMDUZ=.5
 S GMRVTEXT(1)="The following error occurred:"
 S GMRVTEXT(2)=GMRVMSG
 S GMRVTEXT(3)=" "
 S GMRVTEXT(4)="When the error is fixed, please D EN^GMRVFIX to complete the"
 S GMRVTEXT(5)="database repair."
 S XMTEXT="GMRVTEXT("
 D ^XMD
 Q
ROUND(X) ; Round off a number
 N Y
 S X=+$G(X)
 S Y=$J(X,6,2)
 S Y=$$STRIP^XLFSTR(Y," ")
 S Y=+Y
 Q Y
 ;
