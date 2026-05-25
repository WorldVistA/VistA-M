KMPPS45B ;SP/JML - KMP*4*5 PRE INSTALL ROUTINE ;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**5**;3/1/2018;Build 9
 ;
 ;
 ;
ROLES(MDEF) ;
 D MDEF.Implementation.WriteLine("        Return $ROLES")
 Q
TOTBUFF(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        S KMPTBUFF=""""")
 D MDEF.Implementation.WriteLine("        S KMPRNS=$NAMESPACE")
 D MDEF.Implementation.WriteLine("        N $NAMESPACE")
 D MDEF.Implementation.WriteLine("        S $NAMESPACE=""%SYS""")
 D MDEF.Implementation.WriteLine("        S KMPTBUFF=$V($ZU(40,2,17),-2,$ZU(40,0,1))")
 D MDEF.Implementation.WriteLine("        Return KMPTBUFF")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        S $NAMESPACE=KMPRNS")
 D MDEF.Implementation.WriteLine("        Return """"")
 D MDEF.Implementation.WriteLine("    }")
 Q
LISTBUFF(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        S KMPRET=##class(%ArrayOfDataTypes).%New()")
 D MDEF.Implementation.WriteLine("        S KMPRNS=$NAMESPACE")
 D MDEF.Implementation.WriteLine("        N $NAMESPACE")
 D MDEF.Implementation.WriteLine("        S $NAMESPACE=""%SYS""")
 D MDEF.Implementation.WriteLine("        S KMPBUFF=1")
 D MDEF.Implementation.WriteLine("        D display^GLOBUFF(30,.KMPBUFF)")
 D MDEF.Implementation.WriteLine("        S KMPI=0")
 D MDEF.Implementation.WriteLine("        F  S KMPI=$O(KMPBUFF(KMPI)) Q:KMPI=""""  D")
 D MDEF.Implementation.WriteLine("        .S KMPSTAT=KMPRET.SetAt(KMPBUFF(KMPI),KMPI)")
 D MDEF.Implementation.WriteLine("        Return KMPRET")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        S $NAMESPACE=KMPRNS")
 D MDEF.Implementation.WriteLine("        Return """"")
 D MDEF.Implementation.WriteLine("    }")
 Q
CPF(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        S KMPCPFR=##class(%ArrayOfDataTypes).%New()")
 D MDEF.Implementation.WriteLine("        S KMPRNS=$NAMESPACE")
 D MDEF.Implementation.WriteLine("        N $NAMESPACE")
 D MDEF.Implementation.WriteLine("        S $NAMESPACE=""%SYS""")
 D MDEF.Implementation.WriteLine("        S KMPCN=""Config.""_CPFHEAD")
 D MDEF.Implementation.WriteLine("        S KMPMN=""Get""")
 D MDEF.Implementation.WriteLine("        D $CLASSMETHOD(KMPCN,KMPMN,.KMPPROP)")
 D MDEF.Implementation.WriteLine("        S PROP="""",CNT=1")
 D MDEF.Implementation.WriteLine("        F  S PROP=$O(KMPPROP(PROP)) Q:PROP=""""  D")
 D MDEF.Implementation.WriteLine("        .S KMPLIST=$LISTBUILD(PROP,KMPPROP(PROP))")
 D MDEF.Implementation.WriteLine("        .S STAT=KMPCPFR.SetAt(KMPLIST,CNT)")
 D MDEF.Implementation.WriteLine("        .S CNT=CNT+1")
 D MDEF.Implementation.WriteLine("        Return KMPCPFR")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        S $NAMESPACE=KMPRNS")
 D MDEF.Implementation.WriteLine("        Return """"")
 D MDEF.Implementation.WriteLine("    }")
 Q
TOARRAY(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        S KMPRET=##class(%ArrayOfDataTypes).%New()")
 D MDEF.Implementation.WriteLine("        S KMPITR=KMPOBJ.%GetIterator()")
 D MDEF.Implementation.WriteLine("        S KMPI=1")
 D MDEF.Implementation.WriteLine("        WHILE KMPITR.%GetNext(.KMPKEY, .KMPVAL) {")
 D MDEF.Implementation.WriteLine("            S STAT=KMPRET.SetAt(KMPVAL,KMPI)")
 D MDEF.Implementation.WriteLine("            S KMPI=KMPI+1")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        Return KMPRET")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        S $NAMESPACE=KMPRNS")
 D MDEF.Implementation.WriteLine("        Return """"")
 D MDEF.Implementation.WriteLine("    }")
 Q
