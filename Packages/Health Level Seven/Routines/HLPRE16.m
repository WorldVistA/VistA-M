HLPRE16 ;AISC/SAW-Pre-init Routine for DHCP HL7 v. 1.6 ;2/6/95  10:28
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
 ;Quit if version 1.6 has already been installed
 I $G(^DD(771,0,"VR"))=1.6 Q
 W:'$D(ZTQUEUED) !!,"Starting Pre-Init"
 ;Change .01 value of mispelled entry in Field file (#771.1)
 N HLX S HLX=$O(^HL(771.1,"B","RESULTS RPT/STATUSCHNG-DATE/TI",0))
 I HLX S (DIC,DIE)="^HL(771.1,",DA=HLX,DR=".01///RESULTS RPT/STATUS CHNG-DATE/TIME" D ^DIE K DR
 ;Delete old 'AI' cross reference in file 772
 K ^HL(772,"AI")
 ;Delete data, DD and identifier for old single valued Version field (#3)
 ;in files 771.1 to 771.4
 ;Version fields are multiple valued in version 1.6 of the package
 N HLZ F HLX=771.1,771.2,771.3,771.4 D
 .K ^DD(HLX,0,"ID",3)
 .S HLZ=0 F  S HLZ=$O(^HL(HLX,HLZ)) Q:HLZ'>0  I $D(^HL(HLX,HLZ,0)) S $P(^HL(HLX,HLZ,0),"^",3)=""
 .S DIK="^DD("_HLX_",",DA(1)=HLX,DA=3 D ^DIK K DA,DIK
 W:'$D(ZTQUEUED) !,"Pre-Init Finished"
 Q
