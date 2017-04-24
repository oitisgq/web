Dim Status_Old_Value

sub Template_Bug_New()
    on error resume next

    ' fill <Sistema> field if the bug was opened through test execution
    Bug_Put_System_from_Test()

    ' put this field read only all the time
    Bug_Fields(fd_bg_Qtd_Reincidencia).IsReadOnly = True

    ' put this field as read only all the time
    Bug_Fields(fd_bg_Ja_foi_Rejeitado).Value = "N"
    Bug_Fields(fd_bg_Ja_foi_Rejeitado).IsReadOnly = True

    ' alter the bug status based on the workflow transaction for a new bug
    Bug_Allow_Workflow_Transaction()

    ' put some fields when bug status is 'new'. also have conditionals to another status

    'Foi desabilitado para eliminar o pop-up "motivo pendencia"
    ' put the field Motivo visible only if status is equals pendent

    Template_WizardFieldCust_Add() ' Added by wizard
    On Error goto 0
end sub

sub Template_Bug_AfterPost()
    on error resume next
    ' call function to count how many times a bug was reopened
    'Bug_Count_Reopen
    Template_Bug_AfterPost = Template_DefaultRes
    On Error goto 0
end sub

sub Template_Bug_FieldChange(FieldName)  
    on error resume next

 ' 2016/01/25 - JOÃO GUILHERME: Inclusão da nova origem - Automação

    if FieldName = "BG_STATUS" Then
        select case Bug_Fields("BG_STATUS").Value
            case "Reopen"
                Bug_Fields(fd_bg_Natureza_Erro).Value = ""
                Bug_Fields(fd_bg_Origem_Erro).Value = ""
                Bug_Fields(fd_bg_Sistema_Defeito).Value = ""

            case "Rejected"
                if Status_Old_Value <> "Pendent" Then
                    Bug_Fields(fd_bg_Natureza_Erro).Value = ""
                    Bug_Fields(fd_bg_Origem_Erro).Value = ""
                    Bug_Fields(fd_bg_Sistema_Defeito).Value = ""
                end if

            case "Migrate"
                if Status_Old_Value <> "Pendent" Then
                    Bug_Fields(fd_bg_Natureza_Erro).Value = ""
                    Bug_Fields(fd_bg_Origem_Erro).Value = ""
                    Bug_Fields(fd_bg_Sistema_Defeito).Value = ""
                end if

            case "In_Progress"
                if Bug_Fields(fd_bg_Motivo_Pendencia).Value = "CR" Or Bug_Fields(fd_bg_Motivo_Pendencia).Value = "PKE" Then
                    Bug_Fields(fd_bg_Detalhamento_CR_PKE).IsVisible = True
                    Bug_Fields(fd_bg_Detalhamento_CR_PKE).IsRequired = True
                end if

        end select

        Status_Changed = True
    end if

    if Bug_Fields(fd_bg_Motivo_Pendencia).Value = "Pendente de outro defeito" then
       msgbox "Favor, preencher o campo Defeito Pai com o seguinte padrão: PRJ00000000_ENT00000000-DEF000" & vbcrlf & vbcrlf & _
              "PRJ00000000: Id do subprojeto (8 caracteres numéricos)" & vbcrlf & _
              "ENT00000000: Id da entrega (8 caracteres numéricos)" & vbcrlf & _
              "DEF000: ID do defeito (3 caracteres numéricos)"

       Bug_Fields(fd_bg_Defeito_Pai).IsRequired = True
    end if

    '--------------------Teste Guilherme para preencher a origem--------------------

    select case Bug_Fields(fd_bg_Natureza_Erro).Value
        case "ESPECifICAÇÃO FUNCIONAL / CASO DE USO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Desenho da Solução"
        case "ESPECifICAÇÃO TÉCNICA"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Desenho da Solução"
        case "MODELO DE DADOS"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Desenho da Solução"
        case "DATA MAPPING"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Desenho da Solução"
        case "REFERENCE DATA"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Desenho da Solução"
        case "CÓDIGO – CÓDIGO FONTE / EXECUTÁVEL / SCRIPT"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Construção"
        case "RELEASE NOTES / RELEASE NOTES CONSOLIDADO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Construção"
        case "CÓDIGO – PARAMETRIZAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Construção"
        case "CÓDIGO – VERSÃO INCORRETA"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Construção"
        case "AMBIENTE – INDISPONIBILIDADE"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        '2016/06/21 - João Guilherme: Natureza removida
        'case "AMBIENTE – CONECTOR/SERVIÇO"
        '    Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – DISPONIBILIDADE DE PLATAFORMA DA ENGENHARIA"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – MIGRAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – FORNECEDOR EXTERNO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – BANCO DE DADOS"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – PARAMETRIZAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – INFRA–ESTRUTURA"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – APONTAMENTO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "CÓDIGO – ERRO EM PRODUÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Produção"
        case "FALHA DO TESTADOR"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Improcedente"
        case "ESTRATÉGIA DE TESTE"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Improcedente"
        case "PLANO DE TESTES"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Improcedente"
        case "MASSA DE TESTES"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Improcedente"
        case "ACESSO/LOGIN"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Improcedente"

  ' 2016/12/16 - JOÃO GUILHERME: Inclusão de Nova Natureza = TDM – MASSA DE TESTES

    case "TDM – MASSA DE TESTES"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Improcedente"
    ' 2016/12/16 - ____________________________end_____________________________________

        ' 2015/11/17 - JOÃO GUILHERME: Inclusão de Nova Natureza.
        case "AMBIENTE – CÓDIGO DESATUALIZADO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        ' 2016/06/21 - JOÃO GUILHERME: Inclusão de Novas Naturezas.
        case "PARAMETRIZAÇÃO DE AMBIENTE"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Improcedente"
        case "AMBIENTE – SERVIÇO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – RESTART APLICAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – CONECTOR"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"
        case "AMBIENTE – COMPONENTE"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Ambiente"


        case "AMBIENTE – INDISPONIBILIDADE – AUTOMAÇÃO"
      Bug_Fields(fd_bg_Origem_Erro).Value = "Automação"
        case "AMBIENTE – PARAMETRIZAÇÃO – AUTOMAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Automação"
        case "AMBIENTE – CONECTOR/SERVIÇO – AUTOMAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Automação"
        case "CÓDIGO – CÓDIGO FONTE / EXECUTÁVEL / SCRIPT – AUTOMAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Automação"
        case "CÓDIGO – PARAMETRIZAÇÃO – AUTOMAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Automação"
        case "CÓDIGO – RECONFIG. TIMMING SCRIPT – AUTOMAÇÃO"
            Bug_Fields(fd_bg_Origem_Erro).Value = "Automação"

    end select

    '--
    if Bug_Fields("BG_STATUS").Value = PendENT_PROGRESS Then
        Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
        Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
    end if

    if Bug_Fields("BG_STATUS").Value = PendENT_MIGRATE Then
        Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
        Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
    end if

    if Bug_Fields("BG_STATUS").Value = PendENT_RETEST Then
        Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
        Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
    end if

    '-------------------------------------------------------------------------------

    ' flag to tell Bug_Count_Reopen that a value was changed
    ' @see Bug_Count_Reopen

    'Status_Changed = True

    Template_WizardListCust() ' Added by wizard
    On Error goto 0
end sub

function Template_Bug_FieldCanChange(FieldName, NewValue)
    on error resume next

    Status_Old_Value = Bug_Fields("BG_STATUS").Value

    '--------------------Teste Guilherme para limpar a natureza---------------------

    if FieldName = "BG_STATUS" Then
        select case NewValue
            case "In_Progress"
                Bug_Fields(fd_bg_Natureza_Erro).Value = ""    'natureza
                Bug_Fields(fd_bg_Origem_Erro).Value = ""    'origem
                Bug_Fields(fd_bg_Sistema_Defeito).Value = ""

        end select
        'Bug_Reopened
    end if

    Bug_Rejected Bug_Fields("BG_STATUS").Value, NewValue

  'call Bug_FieldCanChange(FieldName, NewValue)
    Template_Bug_FieldCanChange = Template_DefaultRes

    On Error goto 0
end function

function Template_Bug_CanPost()
    on error resume next

    Bug_Count_Reopen()

    if Status_Old_Value <> Bug_Fields("BG_STATUS").Value Then
        select case Status_Old_Value
            case "Pendent (Progress)"
                Bug_Fields(fd_bg_Motivo_Pendencia).Value = "" 'Motivo Pendencia

            case "Pendent (Migrate)"
                Bug_Fields(fd_bg_Motivo_Pendencia).Value = "" 'Motivo Pendencia

            case "Pendent (Retest)"
                Bug_Fields(fd_bg_Motivo_Pendencia).Value = ""
        end select
    end if

    'call Bug_CanPost
    Template_Bug_CanPost = Bug_Send_Email_GA()
    Template_Bug_CanPost = BlockActions

    Bug_Rejeite_YN()

       'Tentativa 2 de dar by pass no new
     select case Bug_Fields("BG_STATUS").Value
            case "New"
            Bug_Fields.Field("BG_STATUS").Value = "In_Progress"
     end select

    On Error goto 0
end function

sub Template_Bug_MoveTo()
    Template_WizardFieldCust_Details() ' Added by wizard
    Template_WizardListCust() ' Added by wizard
    Bug_Allow_Workflow_Transaction()
end sub


'------------------Teste Guilherme deixar campo em branco-----------------------
function Bug_Status_Rejected_Reopen(old_value, new_value)
    if (old_value = REJECTED And new_value = "Reopen") Then
        Bug_Fields(fd_bg_Origem_Erro).Value = ""
        Bug_Fields(fd_bg_Natureza_Erro).Value = ""
    end if


    '  if (old_value = IN_PROGRESS and new_value = "Migrate") Then
    '       Bug_Fields(fd_bg_Origem_Erro).Value = ""
    '       Bug_Fields(fd_bg_Natureza_Erro).Value = ""
    '  end if

end function

function Bug_Status_Rejected_Reopen(old_value, new_value)
    if (old_value = IN_PROGRESS And new_value = "Migrate") Then
        Bug_Fields(fd_bg_Origem_Erro).Value = ""
        Bug_Fields(fd_bg_Natureza_Erro).Value = ""
    end if
end function

'---------------Teste Guilherme para exigir o motivo da pendencia---------------

function Bug_Status_InProgress_Pendent(old_value, new_value)
    if (old_value = IN_PROGRESS And new_value = PendENT_PROGRESS) Then
        Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
        Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
    end if
end function

function Bug_Status_Pendent_Migrate(old_value, new_value)
    if (old_value = MIGRATE And new_value = PendENT_MIGRATE) Then
        Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
        Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
    end if
end function

function Bug_OnRetest_PendentRetest(old_value, new_value)
    if (old_value = ON_RETEST And new_value = PendENT_RETEST) Then
        Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
        Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
    end if
end function

'Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
'Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
'--------------------------------------------------------------------------------
' send an e-mail when a defect status is migrate
' this show up a message box to put the responsible so an e-mail to a group is send
' lastUpdate 11/21/2012

function Bug_Send_Email_GA()

    ' Original
    '    if Bug_Fields("BG_STATUS").Value = MIGRATE Then

    ' inputbox with message to write GA
    '       Result = InputBox(MENSAGEM_EMAIL_GA, "ATENÇÃO")
    '       Result = Ucase(Result)
    '       Set bugObject = TDConnection.BugFactory.Item(Bug_Fields("BG_BUG_ID").Value)
    '       select case Result
    '          case "ACC"
    '             Bug_Send_Email_GA = True
    '             bugObject.Post
    '             bugObject.Mail EMAIL_GA_ACC, "", 0, ASSUNTO_EMAIL_GA, COMENTARIO_EMAIL_GA
    '          case "CSC"
    '             Bug_Send_Email_GA = True
    '             bugObject.Post
    '             bugObject.Mail EMAIL_GA_CSC, "", 0, ASSUNTO_EMAIL_GA, COMENTARIO_EMAIL_GA
    '          case Else
    '             Bug_Send_Email_GA = False
    '            MsgBox MSG_NAO_EXISTE_GA
    '       end select
    '    end if

    'end function
    '
    ' ALterado por Bruno Lessa cardoso em 12/12/2012(12/12/12)
    if Bug_Fields("BG_STATUS").Value = MIGRATE Then

        ' inputbox with message to write GA
        Result = InputBox(MENSAGEM_EMAIL_GA, "ATENÇÃO")
        Result = Ucase(Result)

       Set bugObject = TDConnection.BugFactory.Item(Bug_Fields("BG_BUG_ID").Value)
       select case Result

            case "ACC"
                Bug_Send_Email_GA = True
                bugObject.Post
                bugObject.Mail EMAIL_GA_ACC, "", 0, ASSUNTO_EMAIL_GA, COMENTARIO_EMAIL_GA

          'case "CSC"
            '   Bug_Send_Email_GA = True
            '  bugObject.Post
            '  bugObject.Mail EMAIL_GA_CSC, "", 0, ASSUNTO_EMAIL_GA, COMENTARIO_EMAIL_GA

            case "OI"
                Bug_Send_Email_GA = True
                bugObject.Post
                bugObject.Mail EMAIL_GA_OI, "", 0, ASSUNTO_EMAIL_GA, COMENTARIO_EMAIL_GA

          case "OUTROS"
                Bug_Send_Email_GA = True
            'MsgBox "Entrou OUTROS"

            case Else
                Bug_Send_Email_GA = False

        end select

    end if

end function

'comentado para teste
'function BlockActions
'  Status = Bug_Fields("BG_STATUS").Value
'  if Status = CLOSED Or Status = CANCELLED Then
'     BlockActions = False
'  Elseif Status = MIGRATE Then
'      BlockActions = Bug_Send_Email_GA
'  Else
'      BlockActions = True
'  end if
'end function

function Template_Bug_CanDelete(Entity)
    on error resume next

    'call Bug_CanDelete(Entity)
    Template_Bug_CanDelete = Template_DefaultRes
    On Error goto 0
end function

' ROUTINES GENERATED BY ALM

sub Template_WizardListCust()
    ' This subroutine had been automatically generated by "Script Generator - List Customization".
    ' Any modification you make will be overwritten next time you use the generator.

    ' BEGIN: When primary Status value is changed, Natureza do Erro's selection list will change.
    select case Bug_Fields("BG_STATUS").Value
        case "Cancelled"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Improcedente")
        case "Closed"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case "In_Progress"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case "Migrate"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case "On_Retest"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case "Pendent(Migrate)"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case "Pendent(Progress)"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case "Pendent(Retest)"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case "Rejected"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Improcedente")
        case "Reopen"
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
        case Else
            Bug_Fields(fd_bg_Natureza_Erro).List = Lists("Oi_Natureza_Erro2")
    end select
    ' end: When primary Status value is changed, Natureza do Erro's selection list will change.
end sub

sub Template_WizardFieldCust_Add()
    ' This subroutine had been automatically generated by "Script Generator - Add Defect Field Customization".
    ' Any modification you make will be overwritten next time you use the generator.

    if User.IsInGroup("Analista de Teste") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Cliente Aprovador") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("CSOL") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Desenvolvedor") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Developer") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Gestão de Ambientes") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Gestão de Teste") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Project Manager") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("QATester") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("TDAdmin") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Viewer") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, False, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    end if
end sub

sub Template_WizardFieldCust_Details()
    ' This subroutine had been automatically generated by "Script Generator - Defect Details Field Customization".
    ' Any modification you make will be overwritten next time you use the generator.

    if User.IsInGroup("Analista de Teste") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Cliente Aprovador") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("CSOL") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Desenvolvedor") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Developer") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Gestão de Ambientes") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Gestão de Teste") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Project Manager") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("QATester") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("TDAdmin") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    Elseif User.IsInGroup("Viewer") Then
        Template_SetFieldApp "BG_ACTUAL_FIX_TIME", True, False, 0, 0
        Template_SetFieldApp "BG_BUG_ID", True, False, 0, 1
        Template_SetFieldApp "BG_CLOSING_DATE", True, False, 0, 2
        Template_SetFieldApp "BG_CLOSING_VERSION", True, False, 0, 3
        Template_SetFieldApp "BG_DESCRIPTION", True, False, 0, 4
        Template_SetFieldApp "BG_DETECTED_BY", True, True, 0, 5
        Template_SetFieldApp "BG_DETECTED_IN_RCYC", True, True, 0, 6
        Template_SetFieldApp "BG_DETECTED_IN_REL", True, False, 0, 7
        Template_SetFieldApp "BG_DETECTION_DATE", True, True, 0, 8
        Template_SetFieldApp "BG_DETECTION_VERSION", True, False, 0, 9
        Template_SetFieldApp "BG_DEV_COMMENTS", True, True, 0, 10
        Template_SetFieldApp "BG_ESTIMATED_FIX_TIME", True, False, 0, 11
        Template_SetFieldApp "BG_PLANNED_CLOSING_VER", True, False, 0, 12
        Template_SetFieldApp "BG_PRIORITY", True, False, 0, 13
        Template_SetFieldApp "BG_PROJECT", True, False, 0, 14
        Template_SetFieldApp "BG_REPRODUCIBLE", True, False, 0, 15
        Template_SetFieldApp "BG_RESPONSIBLE", True, False, 0, 16
        Template_SetFieldApp "BG_SEVERITY", True, True, 0, 17
        Template_SetFieldApp "BG_STATUS", True, False, 0, 18
        Template_SetFieldApp "BG_subJECT", True, False, 0, 19
        Template_SetFieldApp "BG_SUMMARY", True, True, 0, 20
        Template_SetFieldApp "BG_TARGET_RCYC", True, False, 0, 21
        Template_SetFieldApp "BG_TARGET_REL", True, False, 0, 22
        Template_SetFieldApp fd_bg_Natureza_Erro, True, True, 0, 23
        Template_SetFieldApp fd_bg_Sistema_Defeito, True, True, 0, 24
        Template_SetFieldApp fd_bg_Sistema_Caso_Teste, True, True, 0, 25
        Template_SetFieldApp fd_bg_Data_Prevista_Solucao_Defeito, True, False, 0, 26
        Template_SetFieldApp fd_bg_Origem_Erro, True, False, 0, 27
        Template_SetFieldApp fd_bg_Qtd_Reincidencia, True, False, 0, 28
        Template_SetFieldApp fd_bg_Ja_foi_Rejeitado, True, False, 0, 29
        Template_SetFieldApp fd_bg_Encaminhado_Para, True, True, 0, 30
        Template_SetFieldApp fd_bg_Motivo_Pendencia, True, False, 0, 31
        Template_SetFieldApp fd_bg_Qtd_CTs_Impactados, True, True, 0, 32
        Template_SetFieldApp "BG_VTS", True, False, 0, 33
    end if
end sub

sub Template_SetFieldApp(FieldName, Vis, Req, PNo, VOrder)
    'Sets a field's appearance
    with Bug_Fields(FieldName)
        .IsVisible = Vis
        .IsRequired = Req
        .PageNo = PNo
        .ViewOrder = VOrder
    end with
end sub

' ROUTINES

sub Bug_Allow_Workflow_Transaction()
    Bug_Fields(fd_bg_Origem_Erro).IsReadOnly = True
    Bug_Fields(fd_bg_Origem_Erro).IsRequired = False

    Bug_Fields(fd_bg_Qtd_Reincidencia).IsReadOnly = True
    Bug_Fields(fd_bg_Qtd_Reincidencia).IsRequired = False

    select case Bug_Fields.Field("BG_STATUS").Value
        case NEWBUG
            if User.IsInGroup(DESENVOLVEDOR) or User.IsInGroup(GESTAO_AMBIENTE) or User.IsInGroup("CSOL") Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_New_InProgress")
            end if

            if (User.IsInGroup(ANALISTA_TESTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Cancelled")
            end if

            if (User.IsInGroup(GESTAO_TESTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_New_Cancelled_InProgress")
            end if

            Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = True
            Bug_Fields(fd_bg_Natureza_Erro).IsRequired = False

            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False
            Bug_Fields(fd_bg_Sistema_Defeito).IsRequired = True

        case IN_PROGRESS
            if User.IsInGroup(DESENVOLVEDOR) or User.IsInGroup(GESTAO_TESTE) or User.IsInGroup(GESTAO_AMBIENTE) or User.IsInGroup("CSOL") Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Migrate_PendentProgress_Rejected")
            elseif (User.IsInGroup(ANALISTA_TESTE)) Then
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = False
            Bug_Fields(fd_bg_Natureza_Erro).IsRequired = True

            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False
            Bug_Fields(fd_bg_Sistema_Defeito).IsRequired = True

        case MIGRATE
            if (User.IsInGroup(DESENVOLVEDOR)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_OnRetest_PendentMigrate")
                Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsReadOnly = True
                'Colocar a Fase/CR/Etapa como somente leitura (Novo)
                Bug_Fields("BG_DETECTED_IN_RCYC").IsReadOnly = True
                Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False
                Bug_Fields("BG_SEVERITY").IsReadOnly = True
                Bug_Fields(fd_bg_Sistema_Caso_Teste).IsReadOnly = True
                Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = True
            end if

            if (User.IsInGroup(ANALISTA_TESTE)) Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = True
                'Colocar a origem do erro como somente leitura (Novo)
                'Colocar a origem do erro como somente leitura (Novo)
                'Colocar a Qtd CTS Impactados como somente leitura (Novo)
                Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsReadOnly = True
                'Colocar a Fase/CR/Etapa como somente leitura (Novo)
                Bug_Fields("BG_DETECTED_IN_RCYC").IsReadOnly = True
                'Colocar a Sistema Defeito como somente leitura (Novo)
                Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = True
                'Colocar a Severidade como somente leitura (Novo)
                Bug_Fields("BG_SEVERITY").IsReadOnly = True
                'Colocar a Sistema Caso de Teste como somente leitura (Novo)
                Bug_Fields(fd_bg_Sistema_Caso_Teste).IsReadOnly = True
                'Colocar a Natureza do erro como somente leitura (Novo)
                Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = True
            end if

            if (User.IsInGroup(GESTAO_TESTE)) Then
                ' show migrate, on_retest, pendent
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Migrate_Retest_Pendent")
                'Colocar a origem do erro como somente leitura (Novo)
                Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False
            end if

            if (User.IsInGroup(GESTAO_AMBIENTE)) Then
                ' show migrate, on_retest
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Migrate_Retest_Pendent")
                'Colocar a origem do erro como somente leitura (Novo)
            end if

            if (User.IsInGroup("CSOL")) Then
                ' show migrate, on_retest, pendent
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_OnRetest_PendentMigrate")
                'Colocar a origem do erro como somente leitura (Novo)
                'Colocar a Qtd CTS Impactados como somente leitura (Novo)
                Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsReadOnly = True
                'Colocar a Fase/CR/Etapa como somente leitura (Novo)
                Bug_Fields("BG_DETECTED_IN_RCYC").IsReadOnly = True
                'Colocar a Sistema Defeito como somente leitura (Novo)
                Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = True
                'Colocar a Severidade como somente leitura (Novo)
                Bug_Fields("BG_SEVERITY").IsReadOnly = True
                'Colocar a Sistema Caso de Teste como somente leitura (Novo)
                Bug_Fields(fd_bg_Sistema_Caso_Teste).IsReadOnly = True
                'Colocar a Natureza do erro como somente leitura (Novo)
                Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = True
            end if

            if (User.IsInGroup("TDAdmin")) Then
                ' show migrate, on_retest, pendent
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_OnRetest_PendentMigrate")
                'Colocar a origem do erro como somente leitura (Novo)
                Bug_Fields(fd_bg_Origem_Erro).IsReadOnly = False
                'Colocar a Qtd CTS Impactados como somente leitura (Novo)
                Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsReadOnly = False
                'Colocar a Fase/CR/Etapa como somente leitura (Novo)
                Bug_Fields("BG_DETECTED_IN_RCYC").IsReadOnly = False
                'Colocar a Sistema Defeito como somente leitura (Novo)
                Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False
                'Colocar a Severidade como somente leitura (Novo)
                Bug_Fields("BG_SEVERITY").IsReadOnly = False
                'Colocar a Sistema Caso de Teste como somente leitura (Novo)
                Bug_Fields(fd_bg_Sistema_Caso_Teste).IsReadOnly = False
                'Colocar a Natureza do erro como somente leitura (Novo)
                Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = False
            end if

            'Colocar a Qtd CTS Impactados como somente leitura (Novo)
            Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsReadOnly = True
            'Colocar a Fase/CR/Etapa como somente leitura (Novo)
            Bug_Fields("BG_DETECTED_IN_RCYC").IsReadOnly = True
            'Colocar a Sistema Defeito como somente leitura (Novo)
            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False
            'Colocar a Severidade como somente leitura (Novo)
            Bug_Fields("BG_SEVERITY").IsReadOnly = True
            'Colocar a Sistema Caso de Teste como somente leitura (Novo)
            Bug_Fields(fd_bg_Sistema_Caso_Teste).IsReadOnly = True

        case ON_RETEST

            if (User.IsInGroup(DESENVOLVEDOR)) Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = True
                'Colocar a origem do erro como somente leitura (Novo)
            end if

            if (User.IsInGroup(ANALISTA_TESTE)) Then
                ' show on_retest, closed, reopen
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Closed_Reopen_Pendent")
                'Colocar a origem do erro como somente leitura (Novo)

            end if

            if (User.IsInGroup(GESTAO_TESTE)) Then
                ' show on_retest, closed, reopen
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Retest_Closed_Reopen_Pendent")
                'Colocar a origem do erro como somente leitura (Novo)

            end if

            if (User.IsInGroup(GESTAO_AMBIENTE)) Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = True
                'Colocar a origem do erro como somente leitura (Novo)

            end if

            if (User.IsInGroup("CSOL")) Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = True
                'Colocar a origem do erro como somente leitura (Novo)
            end if

            Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
            Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = False
            Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = False
            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False

            'TORNAR O CAMPO "ERRO DETECTAVEL EM DESENVOLVIMENTO" OBRIGATÓRIO
            'QUANDO DEFEITO = ON_RETEST - JOAO GUILHERME - 04/03/2016
            'Chamado 000000014079023
            Bug_Fields(fd_bg_Erro_Detectavel_Em_Desenvolvimento).IsRequired = True

        '--------------------------Inclusão dos novos pendentes-------------------------

        case PendENT_PROGRESS
            if (User.IsInGroup(GESTAO_TESTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Progress")
            end if

            if (User.IsInGroup(ANALISTA_TESTE)) Then
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            if (User.IsInGroup(DESENVOLVEDOR)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Progress")
            end if

            if (User.IsInGroup(GESTAO_AMBIENTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Progress")
            end if

            if (User.IsInGroup("CSOL")) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Progress")
            end if

            Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
            Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True

        case PendENT_MIGRATE
            if (User.IsInGroup(GESTAO_TESTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Migrate")
            end if

            if (User.IsInGroup(ANALISTA_TESTE)) Then
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            if (User.IsInGroup(DESENVOLVEDOR)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Migrate")
            end if

            if (User.IsInGroup(GESTAO_AMBIENTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Migrate")
            end if

            if (User.IsInGroup("CSOL")) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Migrate")
            end if

            Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
            Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True

        case PendENT_RETEST
            if (User.IsInGroup(GESTAO_TESTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Retest")
            end if

            if (User.IsInGroup(ANALISTA_TESTE)) Then
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Retest")
            end if

            if (User.IsInGroup(DESENVOLVEDOR)) Then
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            if (User.IsInGroup(GESTAO_AMBIENTE)) Then
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            if (User.IsInGroup("CSOL")) Then
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
            Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True

            'Bug_Motivo
            '           case PendENT
            ' motivo
            '-----
            'Foram comentados os itens abaixo para desativar o Pop-Up do motivo
            'Motivo: não estava aparecendo no momento certo.
            '2013/01/23 - João Guilherme Marques
            'Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
            'Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = True
            '                Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = True
            'Acrescentada linha acima.            

        

        case CANCELLED
            ' put field as read only
            'Bug_Fields("BG_STATUS").IsReadOnly = True
            'Colocar a origem do erro como somente leitura (Novo)
            ' inputbox para que seja preenchido o motivo do cancelamento

            '26/10/2015 - João Guilherme - Trecho de código para que seja habilitadas as alterações
            'no campo Encaminhado para, para o perfil Admin e Gestão de Teste.
            'BEGIN
            if User.IsInGroup("TDAdmin") Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = False
                Bug_Fields("BG_STATUS").IsReadOnly = False
            end if
            if User.IsInGroup(GESTAO_TESTE) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = False
                Bug_Fields("BG_STATUS").IsReadOnly = False
            end if
            if User.IsInGroup(GESTAO_AMBIENTE) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            if User.IsInGroup(ANALISTA_TESTE) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            if User.IsInGroup(DESENVOLVEDOR) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            if User.IsInGroup(CSOL) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

        case REJECTED
            if User.IsInGroup(ANALISTA_TESTE) Then
                ' show Rejected, Reopen
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Rejected_Reopen")
            end if

            if User.IsInGroup(GESTAO_TESTE) Then
                ' show on_retest, closed, reopen
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Rejected_Closed")
            end if

            if User.IsInGroup(GESTAO_AMBIENTE) Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            'new
            if User.IsInGroup("TDAdmin") Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = False
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Rejected_Reopen")

            end if
            '--
            if User.IsInGroup(DESENVOLVEDOR) Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            if User.IsInGroup("CSOL") Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = False
            Bug_Fields(fd_bg_Natureza_Erro).IsRequired = True
            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False
            Bug_Fields(fd_bg_Sistema_Defeito).IsRequired = True
            

        case REOPENED
            if User.IsInGroup(ANALISTA_TESTE) Then
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if

            if (User.IsInGroup(DESENVOLVEDOR) Or User.IsInGroup("CSOL") Or User.IsInGroup(GESTAO_AMBIENTE) Or User.IsInGroup(GESTAO_TESTE) Or User.IsInGroup("TDAdmin")) Then
                ' show Rejected, Reopen
                Bug_Fields("BG_STATUS").List = Lists("Oi_Bug_Rejected_Progress")
            end if

            'new
            if User.IsInGroup("TDAdmin") Then
                ' put field as read only
                Bug_Fields("BG_STATUS").IsReadOnly = False

            end if

            Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = True
            Bug_Fields(fd_bg_Natureza_Erro).IsRequired = False
            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = True
            Bug_Fields(fd_bg_Sistema_Defeito).IsRequired = False
            Bug_Fields(fd_bg_Sistema_Caso_Teste).IsReadOnly = True
            Bug_Fields(fd_bg_Sistema_Caso_Teste).IsRequired = False
            Bug_Fields(fd_bg_Data_Prevista_Solucao_Defeito).IsReadOnly = True
            Bug_Fields(fd_bg_Data_Prevista_Solucao_Defeito).IsRequired = False
            Bug_Fields(fd_bg_Ja_foi_Rejeitado).IsReadOnly = True
            Bug_Fields(fd_bg_Ja_foi_Rejeitado).IsRequired = False
            Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
            Bug_Fields(fd_bg_Encaminhado_Para).IsRequired = False
            Bug_Fields(fd_bg_Motivo_Pendencia).IsReadOnly = True
            Bug_Fields(fd_bg_Motivo_Pendencia).IsRequired = False
            Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsReadOnly = True
            Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsRequired = False
            Bug_Fields("BG_DETECTED_IN_RCYC").IsReadOnly = True
            Bug_Fields("BG_DETECTED_IN_RCYC").IsRequired = False
            Bug_Fields("BG_SEVERITY").IsReadOnly = True
            Bug_Fields("BG_SEVERITY").IsRequired = False
            Bug_Fields("BG_DETECTED_IN_REL").IsReadOnly = True
            Bug_Fields("BG_DETECTED_IN_REL").IsRequired = False
        case CLOSED
            ' put field as read only
            'Bug_Fields("BG_STATUS").IsReadOnly = True
            'Colocar a origem do erro como somente leitura (Novo)

            '26/10/2015 - João Guilherme - Trecho de código para que seja habilitadas as alterações
            'no campo Encaminhado para, para o perfil Admin e Gestão de Teste.
            'BEGIN
            if User.IsInGroup("TDAdmin") Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = False
                Bug_Fields("BG_STATUS").IsReadOnly = False
            end if
            if User.IsInGroup(GESTAO_TESTE) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = False
                Bug_Fields("BG_STATUS").IsReadOnly = False
            end if
            if User.IsInGroup(GESTAO_AMBIENTE) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            if User.IsInGroup(ANALISTA_TESTE) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            if User.IsInGroup(DESENVOLVEDOR) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            if User.IsInGroup(CSOL) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
                Bug_Fields("BG_STATUS").IsReadOnly = True
            end if
            'end

           Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = True
            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = True
            Bug_Fields(fd_bg_Sistema_Caso_Teste).IsReadOnly = True
            Bug_Fields(fd_bg_Data_Prevista_Solucao_Defeito).IsReadOnly = True
            Bug_Fields(fd_bg_Qtd_CTs_Impactados).IsReadOnly = True
            Bug_Fields(fd_bg_Ja_foi_Rejeitado).IsReadOnly = True
            Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = True
            Bug_Fields(fd_bg_Motivo_Pendencia).IsReadOnly = True
            Bug_Fields("BG_DESCRIPTION").IsReadOnly = True
            Bug_Fields("BG_CLOSED_IN_VERSION").IsReadOnly = True
            Bug_Fields("BG_DETECTION_DATE").IsReadOnly = True
            Bug_Fields("BG_SEVERITY").IsReadOnly = True
            Bug_Fields("BG_SUMMARY").IsReadOnly = True
            Bug_Fields("BG_TARGET_RCYC").IsReadOnly = True
            Bug_Fields("BG_DETECTED_IN_RCYC").IsReadOnly = True
            Bug_Fields("BG_DETECTED_IN_REL").IsReadOnly = True
            Bug_Fields("BG_DEV_COMMENTS").IsReadOnly = True
            Bug_Fields("BG_DESCRIPTION").IsReadOnly = True
            Bug_Fields("BG_RESPONSIBLE").IsReadOnly = True

            if User.IsInGroup("TDAdmin") Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = False
                Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = False
                Bug_Fields("BG_DEV_COMMENTS").IsReadOnly = False
            end if
            if User.IsInGroup(GESTAO_TESTE) Then
                Bug_Fields(fd_bg_Encaminhado_Para).IsReadOnly = False
                Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = False
                Bug_Fields("BG_DEV_COMMENTS").IsReadOnly = False
            end if            

    
    
        
        case Else
            ' natureza do erro
            Bug_Fields(fd_bg_Natureza_Erro).IsReadOnly = True
            ' agente solucionador
            Bug_Fields(fd_bg_Sistema_Defeito).IsReadOnly = False

            ' motivo
            Bug_Fields(fd_bg_Motivo_Pendencia).IsVisible = False    end select

end sub


sub Bug_Count_Reopen()
    on error resume next

    if (Status_Changed And Bug_Fields("BG_STATUS").Value = REOPENED) Then
        'Bug_Fields(fd_bg_Qtd_Reincidencia).IsReadOnly = False
        valor_atual = CInt(Bug_Fields(fd_bg_Qtd_Reincidencia).Value)

        if IsNull(valor_atual) Then
            valor_atual = 0
        end if

        Bug_Fields(fd_bg_Qtd_Reincidencia).Value = valor_atual + 1

        'Set td = tdconnection
        'Set com = td.command
        'atual = Bug_Fields(fd_bg_Qtd_Reincidencia).Value

        'if (atual = "") Then atual = 0
        '    atual = atual + 1
        '    'MsgBox "update BUG set " & fd_bg_Qtd_Reincidencia & "= '" & atual & "' WHERE BG_BUG_ID = " & Bug_Fields("BG_BUG_ID").Value
        'com.CommandText = "update BUG set " & fd_bg_Qtd_Reincidencia & "= '" & atual & "' WHERE BG_BUG_ID = " & Bug_Fields("BG_BUG_ID").Value
        'com.execute
        Bug_Fields(fd_bg_Qtd_Reincidencia).IsReadOnly = True
        Status_Changed = False
    end if

    On Error goto 0
end sub


sub Bug_Put_System_from_Test()
    on error resume next

    if Bug_Fields(fd_bg_Sistema_Caso_Teste).Value = "" Then
        Bug_Fields(fd_bg_Sistema_Caso_Teste).Value = Test_Fields(fd_tc_Projeto).Value
    end if

    On Error goto 0
end sub

sub Bug_Rejeite_YN()
    if Bug_Fields("BG_STATUS").Value = REJECTED Then
        Bug_Fields(fd_bg_Ja_foi_Rejeitado).Value = "Y"
    end if
end sub
