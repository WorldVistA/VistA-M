RABWUTL ;HISC/SM - Billing Aware utilities ;3/24/04
 ;;5.0;Radiology/Nuclear Medicine;**41,70,112**;Mar 16,1998;Build 4
 ; BAY/KAM 03/02/2012 RA*5*112 Remedy Ticket 606685 Utilize ICD API
 ;      Ext ref to $$ICDDX^ICDCODE sup DBIA 3990
 Q
ODX(RA) ;ordering diagnosis
 ;RA = ien file 75.1
 ;RAX(n) = ien80^SC^AO^IR^SWAC^MST^SHAD^HNC^CV where pieces 2+ has 1=Y
 ;N RAX,RA1,I,J,RABA,RA751,X
 S RA751=$S($D(RAORD0):RAORD0,1:^RAO(75.1,RA,0))
 D GETDX
 D WRTDX
 Q
GETDX ; get DX and Clin. Indicators from file 75.1
 Q:'$D(^RAO(75.1,RA,"BA"))  S RAX(1)=^("BA")
 S I=0,RA1=1
 F  S I=$O(^RAO(75.1,RA,"BAS",I)) Q:'I  D
 . S RA1=RA1+1
 . S RAX(RA1)=^RAO(75.1,RA,"BAS",I,0)
 .Q
 Q
WRTDX ; write DX and Clin. Inds.
 Q:'$O(RAX(0))
 W !,"Ordering Diagnoses:"
 S I=0
 F  S I=$O(RAX(I)) Q:'I  D
 . ;*112 remedy ticket 606685 Changed next line to use ICD API
 . W !?2,$P($$ICDDX^ICDCODE(+RAX(I)),U,2),?10,$P($$ICDDX^ICDCODE(+RAX(I)),U,4)
 . S X=$P(RAX(I),U,2,9)
 . Q:X'["1"
 . W !,?10,"Clinical Indicator(s):  "
 . F J=1:1:8 I $P(X,U,J) W $S(J=1:"SC",J=2:"AO",J=3:"IR",J=4:"SWAC",J=5:"MST",J=6:"HNC",J=7:"CV",1:"SHAD") W:$P(X,U,J+1,8)["1" ","
 . Q
 Q
