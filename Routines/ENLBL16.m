ENLBL16 ;(WASH ISC)/DH-Locally Determined Fields on Comp List ;8.11.97
 ;;7.0;ENGINEERING;**12,45**;Aug 17, 1993
LOC1 ;Locally specified fields (human readable)
 ; in  DA       = equipment ien
 ;     ENEQY    = # of lines printed (changed)
 N ENC,ENI,ENX
 S (ENC,ENI)=0
 F  S ENI=$O(^DIC(6910,1,2,ENI)) Q:'ENI  D  Q:ENC=2
 . S ENX=$G(^DIC(6910,1,2,ENI,0))
 . Q:'$P(ENX,U)
 . Q:$$GET1^DID(6914,$P(ENX,U),"","MULTIPLE-VALUED")
 . S ENEQY=ENEQY+1,ENC=ENC+1
 . W !,?5,$P(ENX,U,2)_" "_$$GET1^DIQ(6914,DA,$P(ENX,U))
 Q
 ;ENLBL16
