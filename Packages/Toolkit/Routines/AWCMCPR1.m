AWCMCPR1        ;VISN 7/THM-CPRS MONITOR ;Feb 27, 2004
 ;;7.3;TOOLKIT;**84,86**;Jan 09, 2004
 ;
 W !!,$C(7),"You cannot run this program directly.",!,"Application use only !!",!! H 2 Q  ;enter properly
 ;
STRT1 ; tiu
 N AWCDTA S AWCDTA=$G(^AWC(177100.12,1,0))
 I $P(AWCDTA,U,17)'=1 G ENDQ ;master switch
 I $P(AWCDTA,U,2)'=1 G ENDQ ;tiu
 S AWCTYPE=1,AWCSTRT=$H
 Q
 ;
STRT2 ; lab
 N AWCDTA S AWCDTA=$G(^AWC(177100.12,1,0))
 I $P(AWCDTA,U,17)'=1 G ENDQ ;master switch
 I $P(AWCDTA,U,3)'=1 G ENDQ ;lab
 S AWCTYPE=2,AWCSTRT=$H
 Q
 ;
STRT3 ; reminders
 N AWCDTA S AWCDTA=$G(^AWC(177100.12,1,0))
 I $P(AWCDTA,U,17)'=1 G ENDQ ;master switch
 I $P(AWCDTA,U,4)'=1 G ENDQ ;reminders
 S AWCTYPE=3,AWCSTRT=$H
 K AWCDTA
 Q
 ;
END ; record the data
 ; quit if turning on/back on in middle of transaction (AWCTYPE or AWCSTRT missing)
 I '$D(AWCTYPE)!('$D(AWCSTRT)) G ENDQ
 S AWCDTA=$G(^AWC(177100.12,1,0))
 I $P(AWCDTA,U,17)'=1 G ENDQ ;master switch
 I $P(AWCDTA,U,2)'=1 G ENDQ  ;tiu
 I $P(AWCDTA,U,3)'=1 G ENDQ  ;lab
 I $P(AWCDTA,U,4)'=1 G ENDQ  ;reminder
 S AWCEND=$H
 L +^XTMP("AWCCPRS",.5):1 G:'$T ENDQ
 S AWCDA=+$G(^XTMP("AWCCPRS",.5))
 I AWCDA>50000000 S AWCDA=0 ; reset to zero at fifty million entries
 S AWCDA=AWCDA+1,^XTMP("AWCCPRS",.5)=AWCDA
 L -^XTMP("AWCCPRS",.5)
 S AWCFMDT=$$HTFM^XLFDT(AWCSTRT)
 S ^XTMP("AWCCPRS",AWCFMDT,AWCDA,0)=AWCSTRT_U_AWCEND_U_DUZ_U_(+$G(DUZ(2)))_U_AWCTYPE
 ;
ENDQ K AWCDTA,AWCSEC,AWCFMDT,AWCTYPE,AWCSTRT,AWCEND,DO,DD,DIC,DIE,AWCDA
 Q
 ;
PPAGE ; entry point to create updated .htm file
 ; possible values for AWCX are VMS, VMSC, or NT
 S AWCX="",AWCOS=$P(^%ZOSF("OS"),U)
 I AWCOS["VAX DSM" S AWCX="VMS"
 I AWCOS["OpenM-VMS" S AWCX="VMSC"
 I AWCOS["OpenM" S AWCX="VMSC"
 ; To double check for OS
 I $T(OS^%ZOSV)'="" D
 . I $$OS^%ZOSV()="VMS" S AWCX="VMSC"
 . I $$OS^%ZOSV()="NT" S AWCX="NT"
 ;
 K TMP("AWC") D DT^DICRW
 Q:'$D(^AWC(177100.12,1,0))  ;param file not set up
 ; extract the parameters
 S AWCDTA=$G(^AWC(177100.12,1,0))
 S AWCDTA1=$G(^AWC(177100.12,1,1))
 S AWCDHRS=$P(AWCDTA,U,7) I AWCDHRS="" S AWCDHRS=8  ;# hours to display
 S X=$P(AWCDTA,U,8) S AWCMXSEC=$S(X]"":X,1:30) ;number of seconds to display
 S X=$P(AWCDTA,U,9) S AWCTIULN=$S(X]"":X,1:"192,0,0") ;rgb code tiu line
 S X=$P(AWCDTA,U,10) S AWCLABLN=$S(X]"":X,1:"0,192,0") ;rgb code lab line
 S X=$P(AWCDTA,U,11) S AWCREMLN=$S(X]"":X,1:"0,0,192") ;rgb code reminder line
 S X=$P(AWCDTA,U,12) S AWCGRDON=$S(X="y":"true",X="n":"false",1:"true")
 S X=$P(AWCDTA,U,13) S AWCBKGRN=$S(X]"":X,1:"230,230,230") ;rgb code
 S X=$P(AWCDTA1,U,3) S AWCMSRV=$S(X]"":X,1:"") ;server
 S X=$P(AWCDTA1,U,4) S AWCMUSR=$S(X]"":X,1:"") ;user
 S X=$P(AWCDTA1,U,5) S AWCMPW=$S(X]"":X,1:"")  ;passwd
 ;
 K AWCDTA D NOW^%DTC S (AWCENDDT,AWCCURTM)=%,AWCTSEC=3600*AWCDHRS
 S AWCI1=$P(%H,",",1),AWCI2=$P(%H,",",2)
 S AWCI2=(AWCI2-AWCTSEC) I AWCI2<0 S AWCI2=AWCI2+86400,AWCI1=AWCI1-1
 S %H=AWCI1_","_AWCI2 D YMD^%DTC S AWCBEGDT=X_%
 S X=$E(%,2,4),X=X_"0",X=$S($L(X)<4:X_"0",1:X) ;format to four digits, including any leading zeros
 S AWCBEGTM=+X
 S X=$P(AWCCURTM,".",2),X=($E(X,1,3)_"0"),X=$S($L(X)<4:X_"0",1:X) ;format to four digits as above
 S AWCENDTM=+X K ^TMP("AWCTTIM",$J)
 ; This loop skips 60 due to adding 10 to starting number. These two lines
 ; cause it to print 0-50 min, skipping 60, like this: 210 220,230,240,250,300
 I AWCBEGTM>AWCENDTM F X=AWCBEGTM:10:2350 S ^TMP("AWCTTIM",$J,(-9999+X))="" S:$E(X,($L(X)-1),$L(X))=50 X=X+40 S:X=2360 X="0" ;before midnight
 I AWCBEGTM>AWCENDTM F X=0:10:AWCENDTM S ^TMP("AWCTTIM",$J,X)="" S:$E(X,($L(X)-1),$L(X))=50 X=X+40 ;after midnight
 I AWCENDTM>AWCBEGTM F X=AWCBEGTM:10:AWCENDTM S ^TMP("AWCTTIM",$J,X)="" I $E(X,($L(X)-1),($L(X)))=50 S X=X+40 ;normal times
 ;
SORT ; sort the data into a TMP file
 K ^TMP($J)
 F AWCSRTDT=(AWCBEGDT-.000001):0 S AWCSRTDT=$O(^XTMP("AWCCPRS",AWCSRTDT)) Q:AWCSRTDT=""!(AWCSRTDT>AWCENDDT)  DO
 .F DA=0:0 S DA=$O(^XTMP("AWCCPRS",AWCSRTDT,DA)) Q:DA=""  DO
 ..S AWCDTA=$G(^XTMP("AWCCPRS",AWCSRTDT,DA,0)),AWCDIV=$P(AWCDTA,U,4),AWCTYPE=$P(AWCDTA,U,5)
 ..I AWCDIV="" S AWCDIV=+$$SITE^VASITE ;for people without division assignments
 ..S ^TMP($J,AWCDIV,AWCTYPE,AWCSRTDT,DA)=""
 ;
DIVS ; count the divisions for drop-down box on web page (used in AWCMCPR2)
 I '$D(^TMP($J)) D NODATA G PPAGE ;no data yet for time frame being processed
 S AWCDCNTR=0
 F AWCDIV=0:0 S AWCDIV=$O(^TMP($J,AWCDIV)) Q:AWCDIV=""  DO
 .S AWCFDIV(AWCDIV)=$P(^DIC(4,AWCDIV,0),U)_U_$P($G(^DIC(4,+AWCDIV,99)),U)_U
 .S AWCDCNTR=AWCDCNTR+1
 ; if only one division no drop-down box is needed
 I AWCDCNTR=1 K AWCFDIV
 ; generate one HTML page per facility
DIVPG F AWCDIV=0:0 S AWCDIV=$O(^TMP($J,AWCDIV)) Q:AWCDIV=""  DO  G:POP EXIT
 .S AWCDEV=$P($G(^AWC(177100.12,1,0)),U,5) I AWCDEV="" S POP=1 Q  ;no HFS device in param file
 .S (AWCDIVNM,AWCDIVN1)=$P(^DIC(4,AWCDIV,0),U)
 .S AWCDIVNM=$P($G(^DIC(4,+AWCDIV,99)),U) Q:AWCDIVNM=""
 .S AWCFILE=$P(^AWC(177100.12,1,0),U,6)_"_"_AWCDIVNM_".htm" ;web page name with division number
 .Q:AWCFILE=("_"_AWCDIV)!(AWCDEV="")  ;webpage or device is missing in parameter file
 .; Check VMS or NT before you put the \ in the file name
 .I AWCX="NT" D
 ..S AWCZ=$L(AWCDEV) I $E(AWCDEV,AWCZ,AWCZ)'="\" S AWCDEV=AWCDEV_"\" ;add \ if missing
 .D OPEN^%ZISH("AWCCPR1",AWCDEV,AWCFILE,"W") Q:POP
 .S AWCHFIL1=AWCDEV_AWCFILE ;needed for AWCMFTP at end
 .U IO D PART1^AWCMCPR2 ;part 1 of web page
 .;
TMPALL .; make the TMP("AWC", array with all possible hours, increments of ten, for all types 1,2,3, with zero values
 .F T=1:1:3 F X=-99999:0 S X=$O(^TMP("AWCTTIM",$J,X)) Q:X=""  S TMP("AWC",T,X)="0^0"
 .;
DVALS .; count the number of data values to display on graph
 .S AWCVCNTR=0 F X=0:0 S X=$O(TMP("AWC",X)) Q:X=""  F Y=0:0 S Y=$O(TMP("AWC",X,Y)) Q:Y=""  S AWCVCNTR=AWCVCNTR+1
 .S AWCVCNTR=AWCVCNTR/3 ;divide by 3 graph lines
 .; get the data by date range provided and sort the data
 .F AWCTYPE=0:0 S AWCTYPE=$O(^TMP($J,AWCDIV,AWCTYPE)) Q:AWCTYPE=""  DO
 ..F AWCDATE=(AWCBEGDT-.000001):0 S AWCDATE=$O(^TMP($J,AWCDIV,AWCTYPE,AWCDATE)) Q:AWCDATE=""!(AWCDATE>AWCENDDT)  DO
 ...F DA=0:0 S DA=$O(^TMP($J,AWCDIV,AWCTYPE,AWCDATE,DA)) Q:DA=""  DO
 ....S AWCDTA=$G(^XTMP("AWCCPRS",AWCDATE,DA,0)),AWCXSTRT=$P(AWCDTA,U),AWCXEND=$P(AWCDTA,U,2)
 ....S AWCSEC=$$HDIFF^XLFDT(AWCXEND,AWCXSTRT,2)
 ....S Y=AWCDATE X ^DD("DD") S X=$P(Y,"@",2),X=$TR(X,":","")
 ....; sort the times ; AWCX1 is the hours ;AWCX3 is the minutes 
 ....; use 10-minute intervals and put with interval
 ....S AWCX1=$E(X,1,2),AWCX3=$E(X,3,4) ;strip hours and minutes, no seconds although they are there
 ....I "^00^01^02^03^04^05^"[(U_AWCX3_U) S AWCX3="00"
 ....I "^06^07^08^09^10^11^12^13^14^15^"[(U_AWCX3_U) S AWCX3="10"
 ....I "^16^17^18^19^20^21^22^23^24^25^"[(U_AWCX3_U) S AWCX3="20"
 ....I "^26^27^28^29^30^31^32^33^34^35^"[(U_AWCX3_U) S AWCX3="30"
 ....I "^36^37^38^39^40^41^42^43^44^45^"[(U_AWCX3_U) S AWCX3="40"
 ....I "^46^47^48^49^50^51^52^53^54^55^"[(U_AWCX3_U) S AWCX3="50"
 ....I "^56^57^58^59^"[(U_AWCX3_U) S AWCX3="60"
 ....I AWCX3=60 S AWCX3="00",AWCX1=AWCX1+1
 ....I AWCX1=24 S AWCX1="00"
 ....S AWCTIME=+(AWCX1_AWCX3)
 ....;
SETTMP ....; set in TMP("AWC", array ONLY if within our selected range
 ....I $D(TMP("AWC",AWCTYPE,(-9999+AWCTIME))) DO
 .....S $P(TMP("AWC",AWCTYPE,(-9999+(+AWCTIME))),U)=$P($G(TMP("AWC",AWCTYPE,-9999+(+AWCTIME))),U)+AWCSEC
 .....S $P(TMP("AWC",AWCTYPE,(-9999+(+AWCTIME))),U,2)=$P($G(TMP("AWC",AWCTYPE,(-9999+(+AWCTIME)))),U,2)+1
 ....I $D(TMP("AWC",AWCTYPE,+AWCTIME)) DO
 .....S $P(TMP("AWC",AWCTYPE,+AWCTIME),U)=$P($G(TMP("AWC",AWCTYPE,+AWCTIME)),U)+AWCSEC
 .....S $P(TMP("AWC",AWCTYPE,+AWCTIME),U,2)=$P($G(TMP("AWC",AWCTYPE,+AWCTIME)),U,2)+1
 .;
PART2 .D PART2^AWCMCPR2 ;part II of the HTML code
 .; ftp the file
 .D EN^AWCMFTP
 I AWCX="NT" S CMD="S AWCVAR=$ZF(-1,"_"""erase ftpawc.txt"_""""_")" X CMD
 I AWCX="VMS"!(AWCX="VMSC") D PURDEL^AWCMFTP
 ;
EXIT D ^%ZISC
 K %,%H,AWCC,AWCAVG,AWCCNT,AWCDATE,AWCDEV,AWCDHRS,AWCDIV,AWCDT,AWCDTA,AWCEND,AWCFILE,AWCFMDT,AWCSEC,AWCY,AWCX
 K AWCSTRT,AWCTIME,AWCTYPE,AWCZ,AWCBEGTM,DA,DD,DIC,DIE,DO,DR,AWCENDDT,AWCENDTM,AWCLBCNT,AWCPARAM,AWCPCNTR,AWCFDIVN
 K POP,AWCTTIM,AWCVCNTR,X,AWCX1,AWCX3,Y,AWCBEGDT,AWCCURTM,AWCI1,AWCI2,T,AWCTSEC,Z,AWCDIVNM,AWCWL,AWCDVDTA
 K AWCTIULN,AWCLABLN,AWCREMLN,AWCMXSEC,AWCGRDON,AWCBKGRN,AWCDIVN1,AWCFDIV,AWCDVNM,AWCDVNB,AWCWEBRT,AWCDCNTR,AWCFXDTA
 K AWCOS,AWCDTA1,AWCHFIL1,AWCMPW,AWCMSRV,AWCMUSR,AWCMCP,AWCSITE,AWCSITEN,AWCVMSP,AWCOS,AWCSRTDT,AWCXDIV,YYY
 K %I,%ZISHO,%ZISUB,%ZISHF,AWCWBFLD,CMD,AWC,AWCDIR,AWCDIRL,AWCHFILE,AWCHFILL,AWCOS,AWCVAR,Y,%SUBMIT,VMSC,AWCXDA
 K ^TMP("AWCTTIM",$J),^TMP($J),TMP("AWC"),AWCXSTRT,AWCXEND,XDUZ,TMP
 Q
 ;
NODATA ; handle no data for the day-create a zero, dummy record for the home facility.
 ; this only occurs when a page is due to be run but no activity yet.
 S (AWCSTRT,AWCEND)=$H
 S AWCXDIV=$P($G(^AWC(177100.12,1,1)),U,2),AWCXDA=$O(^DIC(4,"D",AWCXDIV,0)) Q:AWCXDA=""
 S AWCXDIV=$P($G(^DIC(4,AWCXDA,99)),U) Q:AWCXDIV=""
 S XDUZ=.5,XDUZ(2)=AWCXDIV,AWCTYPE=1
 L +^XTMP("AWCCPRS",.5):1 Q:'$T
 S AWCDA=+$G(^XTMP("AWCCPRS",.5)),AWCDA=AWCDA+1,^XTMP("AWCCPRS",.5)=AWCDA
 L -^XTMP("AWCCPRS",.5)
 S AWCFMDT=$$HTFM^XLFDT(AWCSTRT)
 S ^XTMP("AWCCPRS",AWCFMDT,AWCDA,0)=AWCSTRT_U_AWCEND_U_XDUZ_U_(+$G(XDUZ(2)))_U_AWCTYPE
 Q
