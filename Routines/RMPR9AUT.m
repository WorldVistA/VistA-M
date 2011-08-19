RMPR9AUT ;HINES IOFO/RVD - DETAILED PO RPC UTILITY ;09/16/03  13:12
 ;;3.0;PROSTHETICS;**90,116**;Feb 09, 1996
 ;input variables:
 ;DUZ = user
 ;RMPRSITE = pointer or IEN of file #669.9
 ;RESULTS = array of all PC number by a user.
 ;list PC number available to the user
A1(DUZ,RMPRSITE) G A2
ENA(RESULTS,DUZ,RMPRSITE) ;broker entry point to list all available PC number.
A2 ;
 I $D(^RMPR(669.9,RMPRSITE,4)) S RMIFSITE=$P($G(^RMPR(669.9,RMPRSITE,4)),U,1)
 I +RMIFSITE'>0 S RESULTS(0)="IFCAP Site is undefined in #669.9" G EXIT1
 ;call IFCAP routine for the list of PC.
 D A1^PRCH7PA4(DUZ,RMIFSITE)
 S N="" F  S N=$O(RESULTS(N)) Q:N=""  D
 .  I $P(RESULTS(N),U,11)="YES" K RESULTS(N) Q
 .  S X=$P(RESULTS(N),U,13) D ^%DT
 .  I Y'>DT K RESUTLS(N) Q
EXIT1 ;exit
 Q
 ;
 ;create file 442.
 ;DUZ = user or initiator of an order
 ;RMPRSITE = pointer or IEN of file #669.9
 ;RESULTS = IEN of file #442 ^ PO number (e.g 499-PA1262)
B1(DUZ,PRCSITE,RMPRSITE,PRCHXXX,PRCHVEN) G B2
ENB(RESULTS,DUZ,PRCSITE,RMPRSITE,PRCHXXX,PRCHVEN,PRC4426) ;broker entry point
B2 ;
 I $D(^RMPR(669.9,RMPRSITE,4)) S RMIFSITE=$P($G(^RMPR(669.9,RMPRSITE,4)),U,1)
 I '$D(RMIFSITE) S RESULTS(0)="IFCAP Site is undefined in #669.9" G EXIT2
 ;call ITCAP routine to create a 442 entry.
 D AD1^PRCH7PA1(DUZ,RMIFSITE,RMPRSITE,PRCHXXX,PRCHVEN,PRC4426)
 ;
EXIT2 ;
 Q
 ;
 ;List all Open detailed Purchased Order
 ;DUZ = user or initiator of an order
 ;RMPRSITE = pointer or IEN of file #669.9
 ;RESULTS = array of all open Detailed PO in file #664.
C1(DUZ,RMPRSITE) G C2
ENC(RESULTS,DUZ,RMPRSITE) ;broker entry point
C2 ;
 S RMCNT=0
 F I=0:0 S I=$O(^RMPR(664,"H","DETAILED",I)) Q:I'>0  D
 .D GETS^DIQ(664,I,".01;.5;8","","RM")
 .Q:$G(RM(664,I_",",8))
 .S RMCNT=RMCNT+1
 .S RESULTS(RMCNT)=RM(664,I_",",.01)_U
 .S RESULTS(RMCNT)=RESULTS(RMCNT)_$G(RM(664,I_",",.5))_U
 Q
 ;
 ;List all Available Cost Center
 ;RMFCP = Fund Control Point
 ;RMPRSITE = pointer or IEN of file #669.9
 ;RESULTS = array of all Cost Center available in a given FCP.
D1(RMFCP,RMPRSITE) G D2
END(RESULTS,RMFCP,RMPRSITE) ;broker entry point
D2 ;
 I $D(^RMPR(669.9,RMPRSITE,4)) S RMIFSITE=$P($G(^RMPR(669.9,RMPRSITE,4)),U,1)
 I '$D(RMIFSITE) S RESULTS(0)="IFCAP Site is undefined in #669.9" Q
 ;access IFCAP API to list available Cost center.
 D B1^PRCH7PA4(RMFCP,RMIFSITE)
 Q
 ;
 ;List all Available BOC
 ;RMCC = Cost Center
 ;RMPRSITE = pointer or IEN of file #669.9
 ;RESULTS = array of all available BOC in a given Cost Center.
E1(RMCC,RMPRSITE) G E2
ENE(RESULTS,RMCC,RMPRSITE) ;broker entry point
E2 ;
 I $D(^RMPR(669.9,RMPRSITE,4)) S RMIFSITE=$P($G(^RMPR(669.9,RMPRSITE,4)),U,1)
 I '$D(RMIFSITE) S RESULTS(0)="IFCAP Site is undefined in #669.9" Q
 ;access IFCAP API to list available Budget Object Code.
 D C1^PRCH7PA4(RMCC,RMIFSITE)
 Q
 ;
 ;List all Available FCP
 ;DUZ = user
 ;RMPRSITE = pointer or IEN of file #669.9
 ;RESULTS = array of all available FCP in a given station.
F1(DUZ,RMPRSITE) G F2
ENF(RESULTS,DUZ,RMPRSITE) ;broker entry point
F2 ;
 I $D(^RMPR(669.9,RMPRSITE,4)) S RMIFSITE=$P($G(^RMPR(669.9,RMPRSITE,4)),U,1)
 I '$D(RMIFSITE) S RESULTS(0)="IFCAP Site is undefined in #669.9" Q
 ;access IFCAP API to list available Fund control Point.
 D D1^PRCH7PA4(DUZ,RMIFSITE)
 Q
 ;
 ;Broker call to link suspense to 2319
 ;RMPR64 = ien of file #664
 ;RMPR68 = ien of file #668
 ;RESULTS = success or failure message.
G1(RMPR64,RMPR68) G G2
ENG(RESULTS,RMPR64,RMPR68) ;broker entry point
G2 ;
 N RMAMIS,RMIDAT,RMIEN60,RMERCHK,RMAR
 S RESULTS=""
 ;do automatic linking to suspense.
 ;loop all the item and get the pointer to 660.
 F I=0:0 S I=$O(^RMPR(664,RMPR64,1,I)) Q:(I'>0)!(RESULTS'="")  D
 .S RMIDAT=$G(^RMPR(664,RMPR64,1,I,0))
 .S RMIEN60=$P(RMIDAT,U,13)
 .Q:'$G(RMIEN60)
 .S RMAMIS=""
 .I $D(^RMPR(660,RMIEN60,"AMS")) S RMAMIS=$G(^RMPR(660,RMIEN60,"AMS"))
 .Q:'$G(RMAMIS)
 .S RMERCHK=0
 .S RMERCHK=$$UP60^RMPRPCE1(RMIEN60,RMPR68,1)
 .I $G(RMERCHK) S RESULTS="Error Linking to file #660" Q
 .S RMERCHK=$$UP68^RMPRPCE1(RMIEN60,RMPR68,RMAMIS)
 .I $G(RMERCHK) S RESULTS="Error Linking to file #668" Q
 I RESULTS="" S RESULTS="PCE linking to suspense is complete"
 Q
 ;
 ;Broker call to list vendor.
 ;RMPR40 = ien of file #440
 ;RESULTS = success or failure message.
H1(RMPR40,RMPRSITE) G H2
ENH(RESULTS,RMPR40,RMPRSITE) ;broker entry point
H2 ;
 I $D(^RMPR(669.9,RMPRSITE,4)) S RMIFSITE=$P($G(^RMPR(669.9,RMPRSITE,4)),U,1)
 I '$D(RMIFSITE) S RESULTS(0)="IFCAP Site is undefined in #669.9" Q
 ;call ifcap API for vendor listing.
 D E1^PRCH7PA4(RMPR40)
 Q
 ;broker call to ask for electronic signature code
 ;DUZ - user IEN
 ;X - electronic code entered by user.
 ;RESULTS - failure or success message.
I1(DUZ,X) G I2
ENI(RESULTS,DUZ,X) ;broker entry point
I2 ;
 N RMCODE
 S RMCODE=$P($G(^VA(200,DUZ,20)),"^",4)
 I RMCODE="" S RESULTS="You have no signature code on file." Q
 ;W !,"Enter Electronic signature Code: "
 ;X ^%ZOSF("EOFF") R X:60 X ^%ZOSF("EON")
 ;I '$T S RESULTS="Failure" Q
 I $E(X)="^" S RESULTS="User up arrowed out." Q
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I $$HASH(X)=RMCODE S RESULTS="Thank you." Q
 S RESULTS="Sorry, but that's not your correct electronic signature code."
 Q
HASH(X) D HASH^XUSHSHP
 Q X
 ;END
