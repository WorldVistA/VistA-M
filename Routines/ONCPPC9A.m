ONCPPC9A ;HIRMFO/GWB - PCE Studies of Prostate Cancer -Print ;8/15/96
 ;;2.11;ONCOLOGY;**6,16**;Mar 07, 1995
IV S TABLE="TABLE IV - FIRST COURSE OF TREATMENT"
 I IOST'?1"C".E W ! D P Q:EX=U  W ! D P Q:EX=U
 W !?25,TABLE,! D P Q:EX=U
 S DIC="^ONCO(165.5,",DR=""
 W !,"SURGERY:",! D P Q:EX=U
 S NCDS=$E(ONC(165.5,IEN,58.1),1,2),NCDSOT=ONC(165.5,IEN,58.1)
 S CDS=$E(ONC(165.5,IEN,58.2),1,2),CDSOT=ONC(165.5,IEN,58.2)
 I (CDS="")!(CDS="00") D
 .S SURG=NCDSOT,SURGDT=ONC(165.5,IEN,58.3)
 I ((CDS'="")&(CDS'="00"))!(NCDS="") D
 .S SURG=CDSOT,SURGDT=ONC(165.5,IEN,50)
 S (SURG1,SURG2)=""
 S LOS=$L(SURG) I LOS<56 S SURG1=SURG G TOS
 S NOP=$L($E(SURG,1,42)," ")
 S SURG1=$P(SURG," ",1,NOP-1),SURG2=$P(SURG," ",NOP,999)
TOS W !,"  TYPE OF SURGERY...................: ",SURG1 D P Q:EX=U
 W:SURG2'="" !,?41,SURG2 D P Q:EX=U
 I (SURG1="")!($E(SURG1,1,2)="00") S SURGDT="88/88"
 W !,"  DATE OF SURGERY...................: ",SURGDT D P Q:EX=U
 W !,"  REASON FOR NO SURGERY.............: ",ONC(165.5,IEN,58) D P Q:EX=U
 W !,"  SURGICAL APPROACH.................: ",ONC(165.5,IEN,74) D P Q:EX=U
 W !,"  RESEARCH PROTOCOL.................: ",ONC(165.5,IEN,624) D P Q:EX=U
 W !!,"RADIATION THERAPY:",! D P Q:EX=U
 W !,"  RADIATION THERAPY.................: ",ONC(165.5,IEN,625) D P Q:EX=U
 W !,"  DATE RADIATION THERAPY BEGAN......: ",ONC(165.5,IEN,51)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCPPC9 W !?15,TABLE_" (continued)",! G IR
 D P Q:EX=U
IR W !,"  INTERSTITIAL RADIATION............: ",ONC(165.5,IEN,626) D P Q:EX=U
 W !!,"  INTERSTITIAL RADIATION ADMINISTERED:",! D P Q:EX=U
 W !,"    IODINE 125......................: ",ONC(165.5,IEN,627) D P Q:EX=U
 W !,"    GOLD 198........................: ",ONC(165.5,IEN,628) D P Q:EX=U
 W !,"    PALLADIUM 103...................: ",ONC(165.5,IEN,629) D P Q:EX=U
 W !,"    IRIDIUM 192.....................: ",ONC(165.5,IEN,630) D P Q:EX=U
 W !,"    OTHER INTERSTITIAL, NOS.........: ",ONC(165.5,IEN,631)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCPPC9 W !?15,TABLE_" (continued)",! G ER
 D P Q:EX=U
ER W !,"  EXTERNAL RADIATION................: ",ONC(165.5,IEN,632) D P Q:EX=U
 W !!,"  EXTERNAL RADIATION ADMINISTERED:",! D P Q:EX=U
 W !,"    PROSTATE REGION ONLY............: ",ONC(165.5,IEN,633) D P Q:EX=U
 W !,"    PROSTATE/PELVIC NODES...........: ",ONC(165.5,IEN,634) D P Q:EX=U
 W !,"    PARA-AORTIC NODES...............: ",ONC(165.5,IEN,635) D P Q:EX=U
 W !,"    DISTANT METASTATIC SITES........: ",ONC(165.5,IEN,636) D P Q:EX=U
 W !,"    OTHER EXTERNAL SITES, NOS.......: ",ONC(165.5,IEN,637)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCPPC9 W !?15,TABLE_" (continued)" G TRD
 D P Q:EX=U
TRD W !!,"  TOTAL RAD DOSE:",! D P Q:EX=U
 W !,"    PROSTATE........................: ",ONC(165.5,IEN,638) D P Q:EX=U
 W !,"    PELVIC NODES....................: ",ONC(165.5,IEN,639) D P Q:EX=U
 W !,"    PARA-AORTIC NODES...............: ",ONC(165.5,IEN,640) D P Q:EX=U
 W !,"    RESEARCH PROTOCOL...............: ",ONC(165.5,IEN,641)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCPPC9 W !?15,TABLE_" (continued)" G HT
 D P Q:EX=U
HT W !!,"HORMONE THERAPY:",! D P Q:EX=U
 W !,"  HORMONE THERAPY...................: ",ONC(165.5,IEN,642) D P Q:EX=U
 W !,"  DATE HORMONE THERAPY BEGAN........: ",ONC(165.5,IEN,54) D P Q:EX=U
 W !!,"  HORMONES ADMINISTERED:" D P Q:EX=U
 W ! D P Q:EX=U
 W !,"    ESTROGENS.......................: ",ONC(165.5,IEN,643) D P Q:EX=U
 W !,"    ANTIANDROGENS...................: ",ONC(165.5,IEN,644) D P Q:EX=U
 W !,"    PROGESTATIONAL AGENTS...........: ",ONC(165.5,IEN,645) D P Q:EX=U
 W !,"    LUTEINIZING HORMONE-RELEASING...: ",ONC(165.5,IEN,646) D P Q:EX=U
 W !,"    ORCHIECTOMY.....................: ",ONC(165.5,IEN,647) D P Q:EX=U
 W !,"    OTHER...........................: ",ONC(165.5,IEN,648)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCPPC9 G V
 S EOT="Y" D P Q:EX=U
V S TABLE="TABLE V - FIRST RECURRENCE"
 I IOST'?1"C".E W ! D P Q:EX=U  W ! D P Q:EX=U
 W !?25,TABLE,! D P Q:EX=U
 W !,"TYPE OF FIRST RECURRENCE............: ",ONC(165.5,IEN,71) D P Q:EX=U
 W !,"DATE OF FIRST RECURRENCE............: ",ONC(165.5,IEN,70) D P Q:EX=U
 W !!,"METHODS USED TO DIAGNOSE FIRST RECURRENCE:",! D P Q:EX=U
 W !,"  BACKACHE..........................: ",ONC(165.5,IEN,649) D P Q:EX=U
 W !,"  BONE SCAN.........................: ",ONC(165.5,IEN,650) D P Q:EX=U
 W !,"  LETHARGY..........................: ",ONC(165.5,IEN,651) D P Q:EX=U
 W !,"  RECTAL EXAM WITH NEEDLE BIOSPY....: ",ONC(165.5,IEN,652) D P Q:EX=U
 W !,"  TUMOR MARKER ELEVATION............: ",ONC(165.5,IEN,653) D P Q:EX=U
 W !,"  WEIGHT LOSS.......................: ",ONC(165.5,IEN,654) D P Q:EX=U
 W !,"  OTHER.............................: ",ONC(165.5,IEN,655)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCPPC9 G VI
 S EOT="Y" D P Q:EX=U
VI D ^ONCPPC9B
KILL ;Kill Variables and Exit
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILN,ONCOBL,EX,TXT,X,Y,SCTIEN,EOT
 Q
P ;Display Data
 I ($Y'<(LIN-2)) D  Q:EX=U  W:EOT="N" !?25,TABLE_" (continued)",!
 .I IOST?1"C".E K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR^ONCPPC9 Q
 S EOT="N" Q
