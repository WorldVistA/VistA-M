PSOCAN3N ;BIR/RTR/SAB/SJA - auto dc rxs due to death ;06/29/07 11:45am
 ;;7.0;OUTPATIENT PHARMACY;**225**;DEC 1997;Build 29
 Q
RMP ;remove Rx if found in array PSORX("PSOL") (Label Queue)
 Q:'$D(PSORX("PSOL"))  S:'$G(DA) DA=$P(PSOLST(ORN),"^",2)
 N I,J,FND,ST1,ST2,ST3 S I=0
 F  S I=$O(PSORX("PSOL",I)) Q:'I  D
 . S ST1=PSORX("PSOL",I) Q:ST1'[(DA_",")
 . S ST3="",FND=0
 . F J=1:1 S ST2=$P(ST1,",",J) Q:'ST2  D
 . . I ST2=DA S FND=1 Q
 . . S ST3=ST3_$S('ST3:"",1:",")_ST2
 . I FND D
 . . S:ST3]"" PSORX("PSOL",I)=ST3_","
 . . K:ST3="" PSORX("PSOL",I)
 . . D:$D(BBRX(I)) RMB^PSOCAN2(I)
 Q
