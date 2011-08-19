LRAPD1 ;AVAMC/REG/WTY/KLL - AP DATA ENTRY ;9/25/00
 ;;5.2;LAB SERVICE;**41,91,248,259,317**;Sep 27, 1994
 ;
 ;WTY;17-AUG-01;Unwrapped text and add kills for DR string
 ;
SP ;Gross Desc/Clinical Hx, Surg Path
 S LRSOP="G"
 K DR S DR=".09///^S X=LRWHO;.012;.013;.014;.015;.016;"
 S DR=DR_".021//^S X=LR(""TR"");1;S:'LR(""FS"") Y=0;1.3"
 S LR(6)=1,DR(2,63.812)=.01
 Q
MSP ;Micro Description/Gross Review, Surg Path
 S LRSOP="M"
 K DR S DR=".09///^S X=LRWHO;S:'LR(""FS"") Y=1;1.3;1;1.1;"
 S DR=DR_"S:'LR(""DX"") Y=.02;1.4;.02;.03;S:'LRV Y=0;.14"
 S (LR(7),LR(6))=1
 Q
BSP ;Micro Description/Snomed Coding
 S LRSOP="B",(LR(2),LR(7),LR(6))=1
 K DR S DR=".09///^S X=LRWHO;S:'LR(""FS"") Y=1;1.3;1;1.1;"
 S DR=DR_"S:'LR(""DX"") Y=.02;1.4;.02;.03;S:'LRV Y=10;.14;10"
 S DR(2,63.12)=".01;D T^LRAPD;S:'LR(8) Y=4;2;4;I '$D(LR(1)) S Y=0;"
 S DR(2,63.12)=DR(2,63.12)_"1;1.5;3"
 S DR(3,63.16)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.82)=".01;D R^LRAPD;.02"
 Q
ASP ;Micro Description/ICD9CM Coding
 S LRSOP="A",(LR(7),LR(6))=1
 K DR S DR=".09///^S X=LRWHO;S:'LR(""FS"") Y=1;1.3;1;1.1;"
 S DR=DR_"S:'LR(""DX"") Y=.02;1.4;.02;.03;S:'LRV Y=80;.14;80"
 Q
SSP ;Supplementary Report, Surg Path
 S (LRSOP,LRSFLG)="S",(LR(2),LR(7),LR(6))=1
 K DR
 ;Entry of Supp rept must be allowed on released reports
 ;S DR="N LRREL D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,LRI) "
 ;S DR=DR_"I LRREL(1) D VMSG^LRAPD1 S LRSFLG="""",Y=0;"
 ;S DR=DR_".09///^S X=LRWHO;.03;10"
 S DR=".09///^S X=LRWHO;.03;10"
 S DR(2,63.12)=".01;D T^LRAPD;S:'LR(8) Y=4;2;4;I '$D(LR(1)) "
 S DR(2,63.12)=DR(2,63.12)_"S Y=0;1;1.5;3"
 S DR(3,63.16)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.82)=".01;D R^LRAPD;.02"
 Q
PSP ;Special Studies, Surg Path
 S LRSOP="P"
 K DR
 S DR="N LRREL D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,LRI) "
 S DR=DR_"I LRREL(1) D VMSG^LRAPD1 S Y=0;.03;10"
 S DR(2,63.12)="5;1.5"
 S DR(3,63.82)=".01;D R^LRAPD;.02",LR(7)=1
 Q
CY ;Gross Desc/Clinic Hx, Cytopath
 S LRSOP="G"
 K DR S DR=".09///^S X=LRWHO;.012;.013;.014;.015;.016;"
 S DR=DR_".021//^S X=LR(""TR"");1"
 S LR(6)=1,DR(2,63.902)=".01;.02"
 Q
MCY ;Micro Desc/Gross Review, Cytopath
 S LRSOP="M"
 K DR S DR=".09///^S X=LRWHO;1;1.1;S:'LR(""DX"") Y=.021;1.4;"
 S DR=DR_".021//^S X=LR(""TR"");.02;.03;.101;S:'LRV Y=0;.14"
 S (LR(7),LR(6))=1
 Q
BCY ;Micro Desc/SNOMED Coding, Cytopath
 S LRSOP="B",DIC(0)="M"
 S (LR(2),LR(7),LR(6))=1
 K DR S DR=".09///^S X=LRWHO;1;1.1;S:'LR(""DX"") Y=.021;1.4;"
 S DR=DR_".021//^S X=LR(""TR"");.02;.03;.101;S:'LRV Y=10;.14;10"
 S DR(2,63.912)=".01;D T^LRAPD;S:'LR(8) Y=4;2;4;"
 S DR(2,63.912)=DR(2,63.912)_"I '$D(LR(1)) S Y=0;1;1.5;3"
 S DR(3,63.916)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.982)=".01;D R^LRAPD;.02"
 Q
ACY ;Micro Desc/ICD9CM Coding
 S LRSOP="A"
 S (LR(7),LR(6))=1
 K DR S DR=".09///^S X=LRWHO;1;1.1;S:'LR(""DX"") Y=.021;1.4;"
 S DR=DR_".021//^S X=LR(""TR"");.02;.03;.101;S:'LRV Y=80;.14;80"
 Q
SCY ;Supplementary Report, Cyto
 S LRSFLG="S"
 S (LR(2),LR(7),LR(6))=1
 K DR
 ;Entry of Supp rept must be allowed on released reports
 ;S DR="N LRREL D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,LRI) "
 ;S DR=DR_"I LRREL(1) D VMSG^LRAPD1 S LRSFLG="""",Y=0;"
 ;S DR=DR_".09///^S X=LRWHO;.03;10"
 S DR=".09///^S X=LRWHO;.03;10"
 S DR(2,63.912)=".01;D T^LRAPD;S:'LR(8) Y=4;2;4;I '$D(LR(1)) "
 S DR(2,63.912)=DR(2,63.912)_"S Y=0;1;1.5;3"
 S DR(3,63.916)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.982)=".01;D R^LRAPD;.02"
 Q
PCY ;Special Studies, Cyto
 K DR
 S DR="N LRREL D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,LRI) "
 S DR=DR_"I LRREL(1) D VMSG^LRAPD1 S Y=0;.03;10"
 S DR(2,63.912)="5;1.5"
 S DR(3,63.982)=".01;D R^LRAPD;.02"
 S LR(7)=1
 Q
EM ;Gross Desc/Clinical Hx, Em
 S LRSOP="G",LR(6)=1
 K DR S DR=".09///^S X=LRWHO;.012;.013;.014;.015;.016;"
 S DR=DR_".021//^S X=LR(""TR"");1"
 S DR(2,63.202)=.01
 Q
MEM ;Micro Desc/Gross Review, EM
 S LRSOP="M"
 K DR S DR=".09///^S X=LRWHO;1;1.1;S:'LR(""DX"") Y=.021;1.4;"
 S DR=DR_".021//^S X=LR(""TR"");.02;.03;S:'LRV Y=0;.14"
 S (LR(7),LR(6))=1
 Q
BEM ;Micro Desc/SNOMED Coding
 S LRSOP="B",(LR(2),LR(7),LR(6))=1
 K DR S DR=".09///^S X=LRWHO;1;1.1;S:'LR(""DX"") Y=.021;1.4;"
 S DR=DR_".021//^S X=LR(""TR"");.02;.03;S:'LRV Y=10;.14;10"
 S DR(2,63.212)=".01;D T^LRAPD;S:'LR(8) Y=4;2;4;"
 S DR(2,63.212)=DR(2,63.212)_"I '$D(LR(1)) S Y=0;1;1.5;3"
 S DR(3,63.216)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.282)=".01;D R^LRAPD;.02"
 Q
AEM ;Micro Desc/ICD9CM Coding
 S LRSOP="A"
 S (LR(7),LR(6))=1
 K DR S DR=".09///^S X=LRWHO;1;1.1;S:'LR(""DX"") Y=.021;1.4;"
 S DR=DR_".021//^S X=LR(""TR"");.02;.03;S:'LRV Y=80;.14;80"
 Q
SEM ;Supplementary Report, EM
 S LRSFLG="S"
 S (LR(2),LR(7),LR(6))=1
 K DR
 ;Entry of Supp rept must be allowed on released reports
 ;S DR="N LRREL D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,LRI) "
 ;S DR=DR_"I LRREL(1) D VMSG^LRAPD1 S LRSFLG="""",Y=0;"
 ;S DR=DR_".09///^S X=LRWHO;.03;10"
 S DR=".09///^S X=LRWHO;.03;10"
 S DR(2,63.212)=".01;D T^LRAPD;S:'LR(8) Y=4;2;4;I '$D(LR(1)) "
 S DR(2,63.212)=DR(2,63.212)_"S Y=0;1;1.5;3"
 S DR(3,63.216)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.282)=".01;D R^LRAPD;.02"
 Q
PEM ;Special Studies, EM
 K DR
 S DR="N LRREL D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,LRI) "
 S DR=DR_"I LRREL(1) D VMSG^LRAPD1 S Y=0;.03;10"
 S DR(2,63.212)=5,LR(7)=1
 Q
VMSG ;Verified message
 N LRMSG
 S LRMSG=$C(7)_"Report verified.  Cannot edit with this option."
 D EN^DDIOL(LRMSG,"","!!")
 Q
