HDISVF06 ;ALB/RMO - 7115.5 File Utilities/API Cont.; 1/11/05@7:04:00
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---- Begin HDIS Status file (#7115.5) API(s) ----
 ;
GETIEN(HDISCODE,HDISTYPE,HDISSIEN) ;Get IEN for the Status by Status Type and Status Code
 ; Input  -- HDISCODE Status Code
 ;           HDISTYPE Status Type  (Optional- Default 1=Client)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISSIEN  HDIS Status file IEN
 ;Initialize output
 S HDISSIEN=""
 ;Check for missing variable, exit if not defined
 I $G(HDISCODE)="" G GETIENQ
 ;Set Status Type to default of 1=Client, if needed
 S HDISTYPE=$S('$D(HDISTYPE):1,1:HDISTYPE)
 ;Check for entry by Status Type and Status Code
 S HDISSIEN=$O(^HDIS(7115.5,"AC",HDISTYPE,HDISCODE,0))
GETIENQ Q +$S($G(HDISSIEN)>0:1,1:0)
 ;
GETCODE(HDISSIEN,HDISCODE) ;Get Status Code for the Status by IEN
 ; Input  -- HDISSIEN  HDIS Status file IEN
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISCODE Status Code
 ;Initialize output
 S HDISCODE=""
 ;Check for missing variable, exit if not defined
 I $G(HDISSIEN)'>0 G GETCODEQ
 ;Check for Status Code by IEN
 I $D(^HDIS(7115.5,HDISSIEN,0)) S HDISCODE=$P(^(0),"^",2)
GETCODEQ Q +$S($G(HDISCODE)'="":1,1:0)
 ;
 ;---- End HDIS Status file (#7115.5) API(s) ----
