GMRGUT4 ;CISC/JH-DATA DICTIONARY UTILITIES (cont.) ;3/6/96
 ;;3.0;Text Generator;**1**;Jan 24, 1996
EN1 ; ENTRY FROM THE MUMPS CROSS-REFERENCE ON THE ENTERED IN ERROR (#5)
 ; FIELD OF THE GMR TEXT (#124.3) FILE.  THIS CROSS-REFERENCE TRIGGERS
 ; THE DATE ENTERED IN ERROR (#5.1) AND USER ENTERING IN ERROR (#5.2)
 ; FIELDS. 
 D NOW^%DTC S GMRG("X")=X,X=%,$P(^GMR(124.3,DA,5),"^",2)=X
 F GMRG=0:0 S GMRG=$O(^DD(124.3,5.1,1,GMRG)) Q:GMRG'>0  X:$D(^DD(124.3,5.1,1,GMRG,1)) ^(1)
 S X=DUZ,$P(^GMR(124.3,DA,5),"^",3)=X
 F GMRG=0:0 S GMRG=$O(^DD(124.3,5.2,1,GMRG)) Q:GMRG'>0  X:$D(^DD(124.3,5.2,1,GMRG,1)) ^(1)
Q1 S X=GMRG("X") K GMRG
 Q
EN7 ; ENTRY FROM AC XREF ON CHILD TEXT (#1) SUBFIELD OF CHILD (#1) FIELD
 ; OF THE GMR AGGREGRATE TERM (#124.2) FILE
 S GMRGX0(0)=$S($D(^GMRD(124.2,DA(1),1,DA,0)):^(0),1:"")
 I GMRGX0("D")\100,$S('(GMRGX0("D")#2):1,GMRGX0("D")#2&'X:1,1:0) S GMRGX0=$P(GMRGX0(0),"^",7) D SDO G:GMRGX0'="" Q7 S GMRGX0=$P(GMRGX0(0),"^",2) D UPC,SDO G Q7
 I GMRGX0("D")\100 S GMRGX0=$P(GMRGX0(0),"^",7) D KDO S GMRGX0=$P(GMRGX0(0),"^",2) D UPC,KDO G Q7
 I GMRGX0("D")\10,GMRGX0("D")#2 S GMRGX0=X D SDO S GMRGX0=$P(GMRGX0(0),"^",2) D UPC,KDO G Q7
 I GMRGX0("D")\10,'(GMRGX0("D")#2) S GMRGX0=X D KDO S GMRGX0=$P(GMRGX0(0),"^",2) D UPC,SDO G Q7
 I '(GMRGX0("D")\10),GMRGX0("D")#2 S GMRGX0=$P(GMRGX0(0),"^",7) D SDO G Q7:GMRGX0'="" S GMRGX0=X D UPC,SDO G Q7
 I '(GMRGX0("D")\10),'(GMRGX0("D")#2) S GMRGX0=$P(GMRGX0(0),"^",7) D SDO S GMRGX0=X D UPC,KDO
Q7 K GMRGX0 Q
 ;
UPC F GMRGX0(1)=1:1:$L(GMRGX0) I $E(GMRGX0,GMRGX0(1))?1L S GMRGX0=$E(GMRGX0,1,GMRGX0(1)-1)_$C($A($E(GMRGX0,GMRGX0(1)))-32)_$E(GMRGX0,GMRGX0(1)+1,$L(GMRGX0))
 Q
 ;
KDO K:GMRGX0'="" ^GMRD(124.2,DA(1),1,"AC",GMRGX0,DA) Q
 ;
SDO Q:$P(GMRGX0(0),"^",6)  S:GMRGX0'="" ^GMRD(124.2,DA(1),1,"AC",GMRGX0,DA)="" Q
 ;
UPD(GMRG) ; This entry point will execute the set/kill logic for the
 ; AUPD xref of the Audit Trail (.01) sub-field of the Audit Trail
 ; (3) sub-field of the Selection (1) multiple of the GMR Text (124.3)
 ; file.  This xref will trigger data into the Date Last Updated (6)
 ; field of the GMR Text file, if the date/time in that field is less
 ; than the date/time of the Audit Trail field.
 ;
 ;     Input variable:  GMRG = 1 if set logic, 2 if kill logic
 ;
 Q:'$D(GMRGRT)  N GMRGDA,GMRGX,GMRGLAUD,GMRGOAUD,GMRGDAT
 S GMRGX=$G(^GMR(124.3,DA(2),0))
 S GMRGOAUD=$P(GMRGX,"^",6),GMRGLAUD=$P(GMRGX,"^",3)
 I GMRG=2 S GMRGDA(2)=DA(2),GMRGDA(1)=0 F  S GMRGDA(1)=$O(^GMR(124.3,GMRGDA(2),1,GMRGDA(1))) Q:GMRGDA(1)'>0  S GMRGDA=0 F  S GMRGDA=$O(^GMR(124.3,GMRGDA(2),1,GMRGDA(1),2,GMRGDA)) Q:GMRGDA'>0  D
 .  I GMRG=2,GMRGDA(1)=DA(1),GMRGDA=DA Q
 .  S GMRGX=$P($G(^GMR(124.3,GMRGDA(2),1,GMRGDA(1),2,GMRGDA,0)),"^")
 .  I GMRGX>GMRGLAUD S GMRGLAUD=GMRGX
 .  Q
 I GMRG=1 S GMRGLAUD=$S(GMRGOAUD<X:X,1:GMRGOAUD)
 I GMRGLAUD'=GMRGOAUD D
 .  S GMRGDAT(124.3,DA(2)_",",6)=GMRGLAUD
 .  D FILE^DIE("","GMRGDAT")
 .  Q
 Q
UPD1 ; Entry from set logic of AUPD xref of Date Created (.03) field of
 ; GMR Text (124.3) file.  This xref will trigger the value of
 ; Date Created into the Date Last Updated (6) field if that field
 ; has no data.
 ;
 N GMRG
 S GMRG=$P($G(^GMR(124.3,DA,0)),"^",6)
 I GMRG="" S GMRGDAT(124.3,DA_",",6)=X D FILE^DIE("","GMRGDAT")
 Q
