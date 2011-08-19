PRCUESIG ;WISC@ALTOONA/CTB/TEN-ROUTINE TO ENTER OR CHANGE ELECTRONIC SIGNATURE CODE (IFCAP) ;5/4/93  8:31 AM
V ;;5.1;IFCAP;**68**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENCODE(X,X1,X2) D EN^XUSHSHP Q X
DECODE(X,X1,X2) D DE^XUSHSHP Q X
HASH(X) D HASH^XUSHSHP Q X
SUM(X) ;CREATE CHECKSUM VALUE FOR STRING
 N I,Y
 S Y=0 F I=1:1:$L(X) S Y=$A(X,I)*I+Y
 Q Y
ESIG(USERNUM,MESSAGE) ;interogate user for electronic signature code
 ;1= valid code entered
 ;0= invalid code entered
 ;-1= user up arrowed out
 ;-2= signature read time out
 ;-3= no signature on file
 NEW X,SIGCODE,ZZI,OUT
 I $G(PRCRMPR) S MESSAGE=1 Q
 S SIGCODE=$P($G(^VA(200,USERNUM,20)),"^",4)
 I SIGCODE="" W !,"You have no signature code on file.  Please contact your IRM staff for assistance.",$C(7),! S MESSAGE=-3 QUIT
 F ZZI=1:1:3 D  Q:OUT]""
 . K OUT
 . W !,"Enter ELECTRONIC SIGNATURE CODE: "
 . X ^%ZOSF("EOFF") R X:60 X ^%ZOSF("EON")
 . I '$T S OUT=-2 QUIT
 . I $E(X)="^" S OUT=-1 QUIT
 . S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . I $$HASH(X)=SIGCODE W ?60,"Thank you." S OUT=1 QUIT
 . W !,"Sorry, but that's not your correct electronic signature code."
 . S OUT=""
 . QUIT
 S MESSAGE=+$G(OUT)
 Q
 ;
NOW() ;Extrinsic function to return current time
 N %,%I,%H,X
 D NOW^%DTC
 QUIT %
 ;
