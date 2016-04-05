module MainsHelper
  def ivc_topics_complete(ivc)
    if ivc.topic_ehr_vendor or ivc.topic_3rdparty_vendor or
      ivc.topic_custom_query or ivc.topic_validate_data or
      ivc.topic_meaningful_use or ivc.topic_cqm_report or
      ivc.topic_data_error or ivc.topic_coding or
      ivc.topic_hit_display or ivc.topic_reminder or
      ivc.topic_self_assessment or ivc.topic_abcs or
      ivc.topic_brainstorm or ivc.topic_observe_flow or
      ivc.topic_share or ivc.topic_connect or
      ivc.topic_resource or ivc.topic_planning or
      ivc.topic_workflow or ivc.topic_roles or
      ivc.topic_qi_support or ivc.topic_consensus or
      ivc.topic_review_data or ivc.topic_qi_display or
      ivc.topic_huddle or ivc.topic_leadership or
      ivc.topic_review_guideline or ivc.topic_discuss_measurement or
      ivc.topic_other
      image_tag("check-mark-blue.png", size: "25")
    else
      raw("&nbsp;")
    end
  end
  def ivc_hlc_complete(ivc)
    if (ivc.milestone_evidence_progress  || 9) == 9 or
      (ivc.milestone_data_progress       || 9) == 9 or
      (ivc.milestone_qi_progress         || 9) == 9 or
      (ivc.milestone_atrisk_progress     || 9) == 9 or
      (ivc.milestone_task_progress       || 9) == 9 or
      (ivc.milestone_selfmgmt_progress   || 9) == 9 or
      (ivc.milestone_community_progress  || 9) == 9
      return raw("&nbsp;")
    else
      return image_tag("check-mark-blue.png", size: "25")
    end
  end
  def ivc_pdsa_complete(ivc)
    # return ivc.high_leverage_change_tests.any?
    check_if(ivc.high_leverage_change_tests.any?)
  end
  def cell_classname(obj, meth, good_value)
    if obj then
      res = obj.send(meth)
      if good_value == 'nonnil' and res then
        'good'
      elsif res and (res >= good_value) then
        'good'
      else
        'bad'
      end
    else
      'bad'
    end
  end
end
