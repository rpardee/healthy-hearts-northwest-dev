class HighLeverageChangeTest < ActiveRecord::Base

  belongs_to :ivcontact


  def list_hlcs
    lst = ""
    HLC_FIELDS.each do |f|
      lst += "#{HLCS[f]}; " if self.send(f)
    end
    lst = "None selected" if lst == ""
    lst
  end


  HLC_FIELDS = [:embed_evidence, :use_data, :xfunc_qi, :id_at_risk, :manage_pops, :self_management, :resource_linkages, :hlc_other]
  HLCS = {
    embed_evidence:    "Embed clinical evidence on ABCS into daily work to guide care for patients.",
    use_data:          "Utilize reliable, robust data to understand and improve ABCS measures.",
    xfunc_qi:          "Establish a regular QI process involving cross-functional teams (QI, care team, huddles, all staff).",
    id_at_risk:        "Identify at-risk patients for prevention outreach.",
    manage_pops:       "Define roles and responsibilities (tasks) across the care team to identify and manage ABCS populations.",
    self_management:   "Deepen patient self-management support for action planning around ABCS.",
    resource_linkages: "Develop robust linkages to smoking cessation, CDSMP, and other evidence-based community resources.",
    hlc_other:         "Other high leverage change."
  }

  HLCS_SHORT = {
    embed_evidence:    "Embed evidence",
    use_data:          "Use data",
    xfunc_qi:          "QI process",
    id_at_risk:        "Identify patients",
    manage_pops:       "Define roles",
    self_management:   "Patient self-management",
    resource_linkages: "Community resources",
    hlc_other:         "Other"
  }

  TEST_STATUSES = [["Continuing testing", 0], ["Adopted change", 1], ["Abandoned", 2]]

end

