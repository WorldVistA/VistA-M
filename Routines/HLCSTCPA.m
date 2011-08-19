HLCSTCPA ;OIFO-O/RJH - (TCP/IP) VMS ;07/26/2007  10:29
 ;;1.6;HEALTH LEVEL SEVEN;**84,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; 1. port number is input from VMS COM file, such as HLSxxxxDSM.COM,
 ;    HLSxxxxCACHE.COM, or HLSxxxxGTM.COM file, where xxxx is port
 ;    number.
 ; 2. find the ien of #870(logical link file) for the multi-listener
 Q
 ;
GTMPORT(%) ; From tcpip ZFOO for GT.M
 ; %: device^port number
 N HLPORT
 S HLPORT=$P($G(%),"^",2)
 I $G(^%ZOSF("OS"))'["GT.M" D ^%ZTER Q
 D IEN
 Q
 ;
PORT ;
 ; HLPORT: port number of multi-listener
 ; input of DSM: % = device^port number of multi-listener
 ; input of Cache: port number of TCPIP
 ;
 N HLPORT
 S HLPORT=0
 I ^%ZOSF("OS")["OpenM" D
 . S HLPORT=$ZF("GETSYM","PORT")
 I ^%ZOSF("OS")["DSM" D
 . S HLPORT=$P(%,"^",2)
 ;
IEN ;
 ; HLIEN870: ien in #870 (logical link file)
 ; HLPRTS: port number in entry to be tested
 ;
 N HLIEN870
 I 'HLPORT D ^%ZTER Q
 S HLIEN870=0
 F  S HLIEN870=$O(^HLCS(870,"E","M",HLIEN870)) Q:'HLIEN870  D  Q:(HLPRTS=HLPORT)
 . S HLPRTS=$P(^HLCS(870,HLIEN870,400),"^",2)
 I 'HLIEN870 D ^%ZTER Q
 ;
 K HLPORT,HLPRTS
 ; patch 122
 S U="^"
 ;
 ;for Cache/VMS
 I ^%ZOSF("OS")["OpenM" D  Q
 . D CACHEVMS(HLIEN870)
 ;
 ;for DSM
 I ^%ZOSF("OS")["DSM" D  Q
 . S $P(%,"^",2)=HLIEN870   ;set % = device^ien of #870
 . K HLIEN870
 . D EN
 ;
 ;for GT.M
 I ^%ZOSF("OS")["GT.M" D  Q
 . S HLDP=HLIEN870   ;set HLDP = ien of #870
 . K HLIEN870
 . D GTMUCX
 ;
 D ^%ZTER
 Q
GTMUCX ; GT.M /VMS tcpip
 ;listener,  % = device^port
 S U="^",IO=$P(%,U)
 ; S IO(0)=$P O IO(0) ;Setup null device
 ; GTM specific code
 S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""")
 X "O IO:(RECORDSIZE=512)"
 D LISTEN^HLCSTCP
 C IO
 Q
 ;
 ; $ x=f$trnlnm("sys$net")  !This is our MBX device
 ; $!
 ; $! for GT.M
 ; $ assign 'f$trnlnm("SYS$NET")' SYS$NET
 ; $! Depending on how your command files are set up, you may need to
 ; $! run the GT.M profile file.
 ; $ @<user$:[gtmmgr]>gtmprofile.com
 ; $ forfoo="$" + f$parse("user$:[gtmmgr.r]ZFOO.exe")
 ; $ PORT=5000
 ; $ data="''x'^''PORT'"
 ; $ forfoo GTMPORT^HLCSTCPA("''data'")
 ;
CACHEVMS(%) ;Cache'/VMS tcpip
 ;listener,  % = HLDP
 I $G(%)="" D ^%ZTER Q
 ; patch 133
 S IO="SYS$NET",U="^",HLDP=%
 S IO(0)="_NLA0:" O IO(0) ;Setup null device
 ; **Cache'/VMS specific code**
 O IO::5 E  D MON^HLCSTCP("Openfail") Q
 X "U IO:(::""-M"")" ;Packet mode like DSM
 D LISTEN^HLCSTCP
 C IO
 Q
 ;
EN ; DSM/VMS tcpip
 ;listener,  % = device^HLDP
 I $G(%)="" D ^%ZTER Q
 ; patch 122
 ; S IO="SYS$NET",U="^",HLDP=$P(%,U,2)
 S U="^",IO=$P(%,U),HLDP=$P(%,U,2)
 ; patch 133
 S IO(0)="_NLA0:" O IO(0) ;Setup null device
 ; **VMS specific code, need to share device**
 O IO:(TCPDEV):60 E  D MON^HLCSTCP("Openfail") Q
 ; patch 122
 D LISTEN^HLCSTCP
 C IO
 Q
