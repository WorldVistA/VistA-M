PSDWL ;BIR/LTL- MFI - WARD LOCATION Message builder for HL7 ; 9 Aug 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 N D0,HLERR,HLEVN,HLNDAP,HLMTN,HLFS,HLECH,HLSDATA,HLSDT,HLSEC,HLCHAR,HLDA,HLDAN,HLDAP,HLDT,HLDT1,HLNDAP0,HLPID,HLQ,HLVER,PSD,X
 S HLNDAP="PSD-NDES" D INIT^HLTRANS I $D(HLERR) D KILL^HLTRANS Q
 S HLMTN="MFN",HLEVN=1,HLSDT=DT
MFI S ^TMP("HLS",$J,HLSDT,1)="MFI"_HLFS_42_$E(HLECH)_"WARD LOCATION"_HLFS_"PSD-CS"_HLFS_"UPD"_HLFS_HLDT1_HLFS_HLFS_"AL",PSD=0,PSD(1)=2
MFE F  S PSD=$O(^DIC(42,PSD)) Q:'PSD  S D0=PSD D WIN^DGPMDDCF S:'X ^TMP("HLS",$J,HLSDT,PSD(1))="MFE"_HLFS_"MUP"_HLFS_HLFS_HLFS_PSD_$E(HLECH)_$P($G(^DIC(42,PSD,0)),U),PSD(1)=PSD(1)+1
SEND D EN^HLTRANS Q
