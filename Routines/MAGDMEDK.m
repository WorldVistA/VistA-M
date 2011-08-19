MAGDMEDK ;WOIFO/LB Routine to find Medicine subspecialty [ 06/20/2001 08:56 ] ; 06/06/2005  09:25
 ;;3.0;IMAGING;**51**;26-August-2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
SUB(MAGSUB,MAGPAT) ;Get Medicine subspecialty and entries.
 ; an array should be produced and only for entries found from call to
 ; api SUB^MCARUTL2:
 ;  MAGMC(#)=data formatted from call to SUB^MCARUTL2
 Q:'$D(MAGPAT)!'$D(MAGSUB)
 N I,II,X,Y,MAGMC,MAGXX,SUB
 S MAGMC(0)="0^0"
 D SUB^MCARUTL2(.MAGXX,MAGPAT,MAGSUB)
 Q:'MAGXX
 S I=0 F  S I=$O(MAGXX(I)) Q:'I  D
 . S (X,Y)="",X=$P(MAGXX(I),"^"),%DT="ST" D ^%DT
 . S MAGMC(MAGPAT,SUB,Y,I)=$G(MAGXX(I))
 . I $D(MAGXX(I,2005)) S II=0 D
 . . F  S II=$O(MAGXX(I,2005,II)) Q:'II  D
 . . . S MAGMC(MAGPAT,SUB,Y,I,2005,II)=MAGXX(I,2005,II)
 S MAGMC(0)="1^"_$G(MAGXX(0))
 Q
PATSUB(MAGSUB1,MAGDFN) ;
 Q:'MAGDFN
 N I,MAGX
 D PATSUB^MCARUTL2(.MAGX,MAGDFN)
 Q:'MAGX
 Q:'$D(MAGX(0))
 S MAGSUB1(0)="1^"_+MAGX_"^"_$P(MAGX(0),"^",2)
 ; MAGSUB1(0)=1^#entries^msg text
 S I=0 F  S I=$O(MAGX(I)) Q:'I  D
 . S MAGSUB1(I)=$P(MAGX(I),"^")_" ("_$P(MAGX(I),"^",2)_")"
 . ; MAGSUB1(#)=OPH (25)  --25 being ien for procedure
 Q
