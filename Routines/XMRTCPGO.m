XMRTCPGO ;(WASH ISC)/THM/CAP-Start XMRTCP ;02/19/98  14:32
 ;;8.0;MailMan;;Jun 28, 2002
JOB ;Job itself out for TCPQUE.COM to use for polling TCPFLAG'd sites
 ;
 ;XMRTCP must have VMS context
 ;The following code starts job w/o VMS context
 ;N % S %="MM-TCP-Poller" I $G(XMINST) S ^TMP("XMRTCP",0)=XMINST
 ;J POLL^XMRTCP:(NAME=%) Q
 ;
 ;Start job with VMS CONTEXT
 G START^XMRTCPGO
 Q
START ;Start XMRTCP w/DCL context
 I $G(XMINST) S ^TMP("XMRTCP",0)=XMINST
 I ^%ZOSF("OS")["MSM" J POLL^XMRTCP Q
 D SPN("XMRTCP","POLL^XMRTCP")
 Q
 ;Spawn out from VMS / run w/DCL context
SPN(X,Y) ;X=Filename right-hand side / Y=Entry point
 D DEL N % S F=X_".COM" O F:NEW U F S F=$ZIO
 W "$DSM/UCI="_$P($ZU(0),",")_"/ENVIRONMENT="_$$OPTION^%SYSUTL("ENVIRONMENT")_" "_Y,!
 S %="$run sys$system:loginout/input="_F_"/output=XMRTCP.log/detach/ast=300/buffer=40960/enqueu=300/file=99/io_buf=64/io_dir=64/job_tab=1024/maximum_work=1864/page=10240/queue_lim=10/work=900/subprocess=30/process=MM-TCP-Poller"
 C F S %=$ZC(%SPAWN,%) I 1
 Q
DEL N %,X S X="DELER^XMRTCPGO",@^%ZOSF("TRAP")
 S %=$ZC(%SPAWN,"DELETE XMRTCP.COM.*")
 S %=$ZC(%SPAWN,"DELETE XMRTCP.LOG.*")
DELER Q
