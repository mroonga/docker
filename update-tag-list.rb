#!/usr/bin/env ruby

mysql_version = ARGV[0]
mroonga_version = ARGV[1]
groonga_version = ARGV[2]

mysql_series = mysql_version.split(".")[0, 2].join(".")
mysql_version_tag = mysql_version.gsub(".", "")
mroonga_version_tag = mroonga_version.gsub(".", "")

readme_md_path = File.join(__dir__, "README.md")
readme_md_content = ""
in_tag_list = false
File.readlines(readme_md_path).each do |line|
  case line
  when /\A### For MySQL #{Regexp.escape(mysql_series)}/
    in_tag_list = true
    readme_md_content << line
  when /\A#/
    in_tag_list = false
    readme_md_content << line
  else
    if in_tag_list
      if /latest/ =~ line
        components = line.split("|")
        tag_width = components[1].size - 2
        mysql_version_width = components[2].size - 2
        components[2] = " %-#*s " % [mysql_version_width, mysql_version]
        mroonga_version_width = components[3].size - 2
        components[3] = " %-#*s " % [mroonga_version_width, mroonga_version]
        groonga_version_width = components[4].size - 2
        components[4] = " %-#*s " % [mroonga_version_width, groonga_version]
        readme_md_content << components.join("|")

        tag = "mysql#{mysql_version_tag}\\_mroonga#{mroonga_version_tag}"
        readme_md_content << [
          "",
          " %-#*s " % [tag_width, tag],
          " %-#*s " % [mysql_version_width, mysql_version],
          " %-#*s " % [mroonga_version_width, mroonga_version],
          " %-#*s " % [groonga_version_width, groonga_version],
          "\n",
        ].join("|")
      else
        readme_md_content << line
      end
    else
      readme_md_content << line
    end
  end
end

File.open(readme_md_path, "w") do |readme_md|
  readme_md.print(readme_md_content)
end
