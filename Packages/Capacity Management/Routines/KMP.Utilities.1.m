 ;KMP.Utilities.1
 ;Generated for class KMP.Utilities.  Do NOT edit. 03/27/2026 10:44:04AM
 ;;34724A79;KMP.Utilities
 ;
zgetBuffers() methodimpl
    TRY {
        S KMPRET=##class(%Library.ArrayOfDataTypes).%New()
        S KMPRNS=$NAMESPACE
        N $NAMESPACE
        S $NAMESPACE="%SYS"
        S KMPBUFF=1
        D display^GLOBUFF(30,.KMPBUFF)
        S KMPI=0
        F  S KMPI=$O(KMPBUFF(KMPI)) Q:KMPI=""  D
        .S KMPSTAT=KMPRET.SetAt(KMPBUFF(KMPI),KMPI)
        Return KMPRET
    } CATCH KMPERR {
        S $NAMESPACE=KMPRNS
        Return ""
    }
	Return
zgetCPF(CPFHEAD) methodimpl
    TRY {
        S KMPCPFR=##class(%Library.ArrayOfDataTypes).%New()
        S KMPRNS=$NAMESPACE
        N $NAMESPACE
        S $NAMESPACE="%SYS"
        S KMPCN="Config."_CPFHEAD
        S KMPMN="Get"
        D $CLASSMETHOD(KMPCN,KMPMN,.KMPPROP)
        S PROP="",CNT=1
        F  S PROP=$O(KMPPROP(PROP)) Q:PROP=""  D
        .S KMPLIST=$LISTBUILD(PROP,KMPPROP(PROP))
        .S STAT=KMPCPFR.SetAt(KMPLIST,CNT)
        .S CNT=CNT+1
        Return KMPCPFR
    } CATCH KMPERR {
        S $NAMESPACE=KMPRNS
        Return ""
    }
	Return
zgetRoles() methodimpl
        Return $ROLES
zgetTotalBuffers() methodimpl
    TRY {
        S KMPTBUFF=""
        S KMPRNS=$NAMESPACE
        N $NAMESPACE
        S $NAMESPACE="%SYS"
        S KMPTBUFF=$V($ZU(40,2,17),-2,$ZU(40,0,1))
        Return KMPTBUFF
    } CATCH KMPERR {
        S $NAMESPACE=KMPRNS
        Return ""
    }
	Return
ztoArray(KMPOBJ) methodimpl
    TRY {
        S KMPRET=##class(%Library.ArrayOfDataTypes).%New()
        S KMPITR=KMPOBJ.%GetIterator()
        S KMPI=1
        WHILE KMPITR.%GetNext(.KMPKEY, .KMPVAL) {
            S STAT=KMPRET.SetAt(KMPVAL,KMPI)
            S KMPI=KMPI+1
        }
        Return KMPRET
    } CATCH KMPERR {
        S $NAMESPACE=KMPRNS
        Return ""
    }
	Return
