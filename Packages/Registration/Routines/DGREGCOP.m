DGREGCOP ;ALB/CLT - COPY RESIDENTIAL TO PERM AND PERM TO RESIDENTIAL ADDRESS ;23 May 2017  1:38 PM
 ;;5.3;Registration;**941**;Aug 13, 1993;Build 73
 ;
EN(DFN) ;PRIMARY ENTRY POINT
R2P(DFN) ;RESIDENTIAL TO PERMANENT ADDRESS COPY
 N DGAR,I,DGZIP,IENS,FDA
 S DGAR=^DPT(DFN,.115)
 F I=1:1:10,19 S DGAR(I)=$P(^DPT(DFN,.115),U,I)
 K ^DPT(DFN,.11)
 S DGZIP=$E(DGAR(6),1,5)
 S IENS=DFN_","
 S FDA(2,IENS,.111)=DGAR(1)
 S FDA(2,IENS,.112)=DGAR(2)
 S FDA(2,IENS,.113)=DGAR(3)
 S FDA(2,IENS,.114)=DGAR(4)
 S FDA(2,IENS,.115)=DGAR(5)
 S FDA(2,IENS,.116)=DGZIP
 S FDA(2,IENS,.1112)=DGAR(6)
 S FDA(2,IENS,.117)=DGAR(7)
 S FDA(2,IENS,.1171)=DGAR(8)
 S FDA(2,IENS,.1172)=DGAR(9)
 S FDA(2,IENS,.1173)=DGAR(10)
 S FDA(2,IENS,.1118)=DGAR(19)
 D FILE^DIE("","FDA")
 Q
P2R(DFN) ;PERMANENT TO RESIDENTIAL ADDRESS COPY
 N DGAR,I,IENS,FDA
 S DGAR=^DPT(DFN,.11)
 F I=1:1:12,18 S DGAR(I)=$P(DGAR,U,I)
 K ^DPT(DFN,.115)
 S IENS=DFN_","
 S FDA(2,IENS,.1151)=DGAR(1)
 S FDA(2,IENS,.1152)=DGAR(2)
 S FDA(2,IENS,.1153)=DGAR(3)
 S FDA(2,IENS,.1154)=DGAR(4)
 S FDA(2,IENS,.1155)=DGAR(5)
 S FDA(2,IENS,.1156)=DGAR(12)
 S FDA(2,IENS,.1157)=DGAR(7)
 S FDA(2,IENS,.11571)=DGAR(8)
 S FDA(2,IENS,.11572)=DGAR(9)
 S FDA(2,IENS,.11573)=DGAR(10)
 S FDA(2,IENS,.1159)=DGAR(18)
 D FILE^DIE("","FDA")
 Q
