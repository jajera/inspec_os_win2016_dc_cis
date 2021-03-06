#
# Profile:: inspec_os_win2016_dc_cis
# Control:: section_18
#
# Copyright:: 2021, The Authors, All Rights Reserved.

control '18.1.1.1_L1_Ensure_Prevent_enabling_lock_screen_camera_is_set_to_Enabled' do
  title "(L1) Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'"
  desc  "
    Disables the lock screen camera toggle switch in PC Settings and prevents a camera from being invoked on the lock screen.

    The recommended state for this setting is: Enabled.

    Rationale: Disabling the lock screen camera extends the protection afforded by the lock screen to camera features.
  "
  impact 1.0
  tag cce: 'CCE-38347-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Personalization') do
    it { should have_property 'NoLockScreenCamera' }
    its('NoLockScreenCamera') { should cmp == 1 }
  end
end

control '18.1.1.2_L1_Ensure_Prevent_enabling_lock_screen_slide_show_is_set_to_Enabled' do
  title "(L1) Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'"
  desc  "
    Disables the lock screen slide show settings in PC Settings and prevents a slide show from playing on the lock screen.

    The recommended state for this setting is: Enabled.

    Rationale: Disabling the lock screen slide show extends the protection afforded by the lock screen to slide show contents.
  "
  impact 1.0
  tag cce: 'CCE-38348-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Personalization') do
    it { should have_property 'NoLockScreenSlideshow' }
    its('NoLockScreenSlideshow') { should cmp == 1 }
  end
end

control '18.1.2.2_L1_Ensure_Allow_input_personalization_is_set_to_Disabled' do
  title "(L1) Ensure 'Allow input personalization' is set to 'Disabled'"
  desc  "
    This policy enables the automatic learning component of input personalization that includes speech, inking, and typing. Automatic learning enables the collection of speech and handwriting patterns, typing history, contacts, and recent calendar information. It is required for the use of Cortana. Some of this collected information may be stored on the user's OneDrive, in the case of inking and typing; some of the information will be uploaded to Microsoft to personalize speech.

    The recommended state for this setting is: Disabled.

    Rationale: If this setting is Enabled sensitive information could be stored in the cloud or sent to Microsoft.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\InputPersonalization') do
    it { should have_property 'AllowInputPersonalization' }
    its('AllowInputPersonalization') { should cmp == 0 }
  end
end

control '18.3.2_L1_Ensure_Configure_SMB_v1_client_driver_is_set_to_Enabled_Disable_driver' do
  title "(L1) Ensure 'Configure SMB v1 client driver' is set to 'Enabled: Disable driver'"
  desc  "
    This setting configures the start type for the Server Message Block version 1 (SMBv1) client driver service (MRxSmb10), which is recommended to be disabled.

    The recommended state for this setting is: Enabled: Disable driver.

    **Note:** Do not, **under any circumstances**, configure this overall setting as Disabled, as doing so will delete the underlying registry entry altogether, which will cause serious problems.

    Rationale: Since September 2016, Microsoft has strongly encouraged that SMBv1 be disabled and no longer used on modern networks, as it is a 30 year old design that is much more vulnerable to attacks then much newer designs such as SMBv2 and SMBv3.

    More information on this can be found at the following links:

    [Stop using SMB1 | Storage at Microsoft](https://blogs.technet.microsoft.com/filecab/2016/09/16/stop-using-smb1/)

    [Disable SMB v1 in Managed Environments with Group Policy &#x2013; \"Stay Safe\" Cyber Security Blog](https://blogs.technet.microsoft.com/staysafe/2017/05/17/disable-smb-v1-in-managed-environments-with-ad-group-policy/)

    [Disabling SMBv1 through Group Policy &#x2013; Microsoft Security Guidance blog](https://blogs.technet.microsoft.com/secguide/2017/06/15/disabling-smbv1-through-group-policy/)
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\mrxsmb10') do
    it { should have_property 'Start' }
    its('Start') { should cmp == 4 }
  end
end

control '18.3.3_L1_Ensure_Configure_SMB_v1_server_is_set_to_Disabled' do
  title "(L1) Ensure 'Configure SMB v1 server' is set to 'Disabled'"
  desc  "
    This setting configures the server-side processing of the Server Message Block version 1 (SMBv1) protocol.

    The recommended state for this setting is: Disabled.

    Rationale: Since September 2016, Microsoft has strongly encouraged that SMBv1 be disabled and no longer used on modern networks, as it is a 30 year old design that is much more vulnerable to attacks then much newer designs such as SMBv2 and SMBv3.

    More information on this can be found at the following links:

    [Stop using SMB1 | Storage at Microsoft](https://blogs.technet.microsoft.com/filecab/2016/09/16/stop-using-smb1/)

    [Disable SMB v1 in Managed Environments with Group Policy &#x2013; \"Stay Safe\" Cyber Security Blog](https://blogs.technet.microsoft.com/staysafe/2017/05/17/disable-smb-v1-in-managed-environments-with-ad-group-policy/)

    [Disabling SMBv1 through Group Policy &#x2013; Microsoft Security Guidance blog](https://blogs.technet.microsoft.com/secguide/2017/06/15/disabling-smbv1-through-group-policy/)
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanServer\\Parameters') do
    it { should have_property 'SMB1' }
    its('SMB1') { should cmp == 0 }
  end
end

control '18.3.4_L1_Ensure_Enable_Structured_Exception_Handling_Overwrite_Protection_SEHOP_is_set_to_Enabled' do
  title "(L1) Ensure 'Enable Structured Exception Handling Overwrite Protection (SEHOP)' is set to 'Enabled'"
  desc  "
    Windows includes support for Structured Exception Handling Overwrite Protection (SEHOP). We recommend enabling this feature to improve the security profile of the computer.

    The recommended state for this setting is: Enabled.

    Rationale: This feature is designed to block exploits that use the Structured Exception Handler (SEH) overwrite technique. This protection mechanism is provided at run-time. Therefore, it helps protect applications regardless of whether they have been compiled with the latest improvements, such as the /SAFESEH option.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\kernel') do
    it { should have_property 'DisableExceptionChainValidation' }
    its('DisableExceptionChainValidation') { should cmp == 0 }
  end
end

control '18.3.5_L1_Ensure_Turn_on_Windows_Defender_protection_against_Potentially_Unwanted_Applications_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn on Windows Defender protection against Potentially Unwanted Applications' is set to 'Enabled'"
  desc  "
    Enabling this Windows Defender feature will protect against Potentially Unwanted Applications (PUA), which are sneaky unwanted application bundlers or their bundled applications to deliver adware or malware.

    The recommended state for this setting is: Enabled.

    For more information, see this link: [Block Potentially Unwanted Applications with Windows Defender AV | Microsoft Docs](https://docs.microsoft.com/en-us/windows/threat-protection/windows-defender-antivirus/detect-block-potentially-unwanted-apps-windows-defender-antivirus)

    Rationale: This opt-in feature is free and could prevent malicious software from being installed.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\MpEngine') do
    it { should have_property 'MpEnablePus' }
    its('MpEnablePus') { should cmp == 1 }
  end
end

control '18.3.6_L1_Ensure_WDigest_Authentication_is_set_to_Disabled' do
  title "(L1) Ensure 'WDigest Authentication' is set to 'Disabled'"
  desc  "
    When WDigest authentication is enabled, Lsass.exe retains a copy of the user's plaintext password in memory, where it can be at risk of theft. If this setting is not configured, WDigest authentication is disabled in Windows 8.1 and in Windows Server 2012 R2; it is enabled by default in earlier versions of Windows and Windows Server.

    For more information about local accounts and credential theft, review the \"[Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft Techniques](http://www.microsoft.com/en-us/download/details.aspx?id=36036)\" documents.

    For more information about UseLogonCredential, see Microsoft Knowledge Base article 2871997: [Microsoft Security Advisory Update to improve credentials protection and management May 13, 2014](https://support.microsoft.com/en-us/kb/2871997).

    The recommended state for this setting is: Disabled.

    Rationale: Preventing the plaintext storage of credentials in memory may reduce opportunity for credential theft.
  "
  impact 1.0
  tag cce: 'CCE-38444-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\WDigest') do
    it { should have_property 'UseLogonCredential' }
    its('UseLogonCredential') { should cmp == 0 }
  end
end

control '18.4.1_L1_Ensure_MSS_AutoAdminLogon_Enable_Automatic_Logon_not_recommended_is_set_to_Disabled' do
  title "(L1) Ensure 'MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)' is set to 'Disabled'"
  desc  "
    This setting is separate from the Welcome screen feature in Windows XP and Windows Vista; if that feature is disabled, this setting is not disabled. If you configure a computer for automatic logon, anyone who can physically gain access to the computer can also gain access to everything that is on the computer, including any network or networks to which the computer is connected. Also, if you enable automatic logon, the password is stored in the registry in plaintext, and the specific registry key that stores this value is remotely readable by the Authenticated Users group.

    For additional information, see Microsoft Knowledge Base article 324737: [How to turn on automatic logon in Windows](https://support.microsoft.com/en-us/kb/324737).

    The recommended state for this setting is: Disabled.

    Rationale: If you configure a computer for automatic logon, anyone who can physically gain access to the computer can also gain access to everything that is on the computer, including any network or networks that the computer is connected to. Also, if you enable automatic logon, the password is stored in the registry in plaintext. The specific registry key that stores this setting is remotely readable by the Authenticated Users group. As a result, this entry is appropriate only if the computer is physically secured and if you ensure that untrusted users cannot remotely see the registry.
  "
  impact 1.0
  tag cce: 'CCE-37067-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    it { should have_property 'AutoAdminLogon' }
    its('AutoAdminLogon') { should eq '0' }
  end
end

control '18.4.2_L1_Ensure_MSS_DisableIPSourceRouting_IPv6_IP_source_routing_protection_level_protects_against_packet_spoofing_is_set_to_Enabled_Highest_protection_source_routing_is_completely_disabled' do
  title "(L1) Ensure 'MSS: (DisableIPSourceRouting IPv6) IP source routing protection level (protects against packet spoofing)' is set to 'Enabled: Highest protection, source routing is completely disabled'"
  desc  "
    IP source routing is a mechanism that allows the sender to determine the IP route that a datagram should follow through the network.

    The recommended state for this setting is: Enabled: Highest protection, source routing is completely disabled.

    Rationale: An attacker could use source routed packets to obscure their identity and location. Source routing allows a computer that sends a packet to specify the route that the packet takes.
  "
  impact 1.0
  tag cce: 'CCE-36871-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Tcpip6\\Parameters') do
    it { should have_property 'DisableIPSourceRouting' }
    its('DisableIPSourceRouting') { should cmp == 2 }
  end
end

control '18.4.3_L1_Ensure_MSS_DisableIPSourceRouting_IP_source_routing_protection_level_protects_against_packet_spoofing_is_set_to_Enabled_Highest_protection_source_routing_is_completely_disabled' do
  title "(L1) Ensure 'MSS: (DisableIPSourceRouting) IP source routing protection level (protects against packet spoofing)' is set to 'Enabled: Highest protection, source routing is completely disabled'"
  desc  "
    IP source routing is a mechanism that allows the sender to determine the IP route that a datagram should take through the network. It is recommended to configure this setting to Not Defined for enterprise environments and to Highest Protection for high security environments to completely disable source routing.

    The recommended state for this setting is: Enabled: Highest protection, source routing is completely disabled.

    Rationale: An attacker could use source routed packets to obscure their identity and location. Source routing allows a computer that sends a packet to specify the route that the packet takes.
  "
  impact 1.0
  tag cce: 'CCE-36535-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Tcpip\\Parameters') do
    it { should have_property 'DisableIPSourceRouting' }
    its('DisableIPSourceRouting') { should cmp == 2 }
  end
end

control '18.4.4_L1_Ensure_MSS_EnableICMPRedirect_Allow_ICMP_redirects_to_override_OSPF_generated_routes_is_set_to_Disabled' do
  title "(L1) Ensure 'MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes' is set to 'Disabled'"
  desc  "
    Internet Control Message Protocol (ICMP) redirects cause the IPv4 stack to plumb host routes. These routes override the Open Shortest Path First (OSPF) generated routes.

    The recommended state for this setting is: Disabled.

    Rationale: This behavior is expected. The problem is that the 10 minute time-out period for the ICMP redirect-plumbed routes temporarily creates a network situation in which traffic will no longer be routed properly for the affected host. Ignoring such ICMP redirects will limit the system's exposure to attacks that will impact its ability to participate on the network.
  "
  impact 1.0
  tag cce: 'CCE-37988-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Tcpip\\Parameters') do
    it { should have_property 'EnableICMPRedirect' }
    its('EnableICMPRedirect') { should cmp == 0 }
  end
end

control '18.4.6_L1_Ensure_MSS_NoNameReleaseOnDemand_Allow_the_computer_to_ignore_NetBIOS_name_release_requests_except_from_WINS_servers_is_set_to_Enabled' do
  title "(L1) Ensure 'MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers' is set to 'Enabled'"
  desc  "
    NetBIOS over TCP/IP is a network protocol that among other things provides a way to easily resolve NetBIOS names that are registered on Windows-based systems to the IP addresses that are configured on those systems. This setting determines whether the computer releases its NetBIOS name when it receives a name-release request.

    The recommended state for this setting is: Enabled.

    Rationale: The NetBT protocol is designed not to use authentication, and is therefore vulnerable to spoofing. Spoofing makes a transmission appear to come from a user other than the user who performed the action. A malicious user could exploit the unauthenticated nature of the protocol to send a name-conflict datagram to a target computer, which would cause the computer to relinquish its name and not respond to queries.

    An attacker could send a request over the network and query a computer to release its NetBIOS name. As with any change that could affect applications, it is recommended that you test this change in a non-production environment before you change the production environment.

    The result of such an attack could be to cause intermittent connectivity issues on the target computer, or even to prevent the use of Network Neighborhood, domain logons, the NET SEND command, or additional NetBIOS name resolution.
  "
  impact 1.0
  tag cce: 'CCE-36879-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\NetBT\\Parameters') do
    it { should have_property 'nonamereleaseondemand' }
    its('nonamereleaseondemand') { should cmp == 1 }
  end
end

control '18.4.8_L1_Ensure_MSS_SafeDllSearchMode_Enable_Safe_DLL_search_mode_recommended_is_set_to_Enabled' do
  title "(L1) Ensure 'MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)' is set to 'Enabled'"
  desc  "
    The DLL search order can be configured to search for DLLs that are requested by running processes in one of two ways:

    * Search folders specified in the system path first, and then search the current working folder.
    * Search current working folder first, and then search the folders specified in the system path.
    When enabled, the registry value is set to 1. With a setting of 1, the system first searches the folders that are specified in the system path and then searches the current working folder. When disabled the registry value is set to 0 and the system first searches the current working folder and then searches the folders that are specified in the system path.

    Applications will be forced to search for DLLs in the system path first. For applications that require unique versions of these DLLs that are included with the application, this entry could cause performance or stability problems.

    The recommended state for this setting is: Enabled.

    Rationale: If a user unknowingly executes hostile code that was packaged with additional files that include modified versions of system DLLs, the hostile code could load its own versions of those DLLs and potentially increase the type and degree of damage the code can render.
  "
  impact 1.0
  tag cce: 'CCE-36351-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager') do
    it { should have_property 'SafeDllSearchMode' }
    its('SafeDllSearchMode') { should cmp == 1 }
  end
end

control '18.4.9_L1_Ensure_MSS_ScreenSaverGracePeriod_The_time_in_seconds_before_the_screen_saver_grace_period_expires_0_recommended_is_set_to_Enabled_5_or_fewer_seconds' do
  title "(L1) Ensure 'MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires (0 recommended)' is set to 'Enabled: 5 or fewer seconds'"
  desc  "
    Windows includes a grace period between when the screen saver is launched and when the console is actually locked automatically when screen saver locking is enabled.

    The recommended state for this setting is: Enabled: 5 or fewer seconds.

    Rationale: The default grace period that is allowed for user movement before the screen saver lock takes effect is five seconds. If you leave the default grace period configuration, your computer is vulnerable to a potential attack from someone who could approach the console and attempt to log on to the computer before the lock takes effect. An entry to the registry can be made to adjust the length of the grace period.
  "
  impact 1.0
  tag cce: 'CCE-37993-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    it { should have_property 'ScreenSaverGracePeriod' }
    its('ScreenSaverGracePeriod') { should cmp <= 5 }
  end
end

control '18.4.12_L1_Ensure_MSS_WarningLevel_Percentage_threshold_for_the_security_event_log_at_which_the_system_will_generate_a_warning_is_set_to_Enabled_90_or_less' do
  title "(L1) Ensure 'MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning' is set to 'Enabled: 90% or less'"
  desc  "
    This setting can generate a security audit in the Security event log when the log reaches a user-defined threshold.

    The recommended state for this setting is: Enabled: 90% or less.

    **Note:** If log settings are configured to Overwrite events as needed or Overwrite events older than x days, this event will not be generated.

    Rationale: If the Security log reaches 90 percent of its capacity and the computer has not been configured to overwrite events as needed, more recent events will not be written to the log. If the log reaches its capacity and the computer has been configured to shut down when it can no longer record events to the Security log, the computer will shut down and will no longer be available to provide network services.
  "
  impact 1.0
  tag cce: 'CCE-36880-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Eventlog\\Security') do
    it { should have_property 'WarningLevel' }
    its('WarningLevel') { should cmp <= 90 }
  end
end

control '18.5.8.1_L1_Ensure_Enable_insecure_guest_logons_is_set_to_Disabled' do
  title "(L1) Ensure 'Enable insecure guest logons' is set to 'Disabled'"
  desc  "
    This policy setting determines if the SMB client will allow insecure guest logons to an SMB server.

    The recommended state for this setting is: Disabled.

    Rationale: Insecure guest logons are used by file servers to allow unauthenticated access to shared folders.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\LanmanWorkstation') do
    it { should have_property 'AllowInsecureGuestAuth' }
    its('AllowInsecureGuestAuth') { should cmp == 0 }
  end
end

control '18.5.11.2_L1_Ensure_Prohibit_installation_and_configuration_of_Network_Bridge_on_your_DNS_domain_network_is_set_to_Enabled' do
  title "(L1) Ensure 'Prohibit installation and configuration of Network Bridge on your DNS domain network' is set to 'Enabled'"
  desc  "
    You can use this procedure to controls user's ability to install and configure a Network Bridge.

    The recommended state for this setting is: Enabled.

    Rationale: The Network Bridge setting, if enabled, allows users to create a Layer 2 Media Access Control (MAC) bridge, enabling them to connect two or more physical network segments together. A Network Bridge thus allows a computer that has connections to two different networks to share data between those networks.

    In an enterprise managed environment, where there is a need to control network traffic to only authorized paths, allowing users to create a Network Bridge increases the risk and attack surface from the bridged network.
  "
  impact 1.0
  tag cce: 'CCE-38002-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Network Connections') do
    it { should have_property 'NC_AllowNetBridge_NLA' }
    its('NC_AllowNetBridge_NLA') { should cmp == 0 }
  end
end

control '18.5.11.3_L1_Ensure_Prohibit_use_of_Internet_Connection_Sharing_on_your_DNS_domain_network_is_set_to_Enabled' do
  title "(L1) Ensure 'Prohibit use of Internet Connection Sharing on your DNS domain network' is set to 'Enabled'"
  desc  "
    Although this \"legacy\" setting traditionally applied to the use of Internet Connection Sharing (ICS) in Windows 2000, Windows XP  Server 2003, this setting now freshly applies to the Mobile Hotspot feature in Windows 10  Server 2016.

    The recommended state for this setting is: Enabled.

    Rationale: Non-administrators should not be able to turn on the Mobile Hotspot feature and open their Internet connectivity up to nearby mobile devices.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Network Connections') do
    it { should have_property 'NC_ShowSharedAccessUI' }
    its('NC_ShowSharedAccessUI') { should cmp == 0 }
  end
end

control '18.5.11.4_L1_Ensure_Require_domain_users_to_elevate_when_setting_a_networks_location_is_set_to_Enabled' do
  title "(L1) Ensure 'Require domain users to elevate when setting a network's location' is set to 'Enabled'"
  desc  "
    This policy setting determines whether to require domain users to elevate when setting a network's location.

    The recommended state for this setting is: Enabled.

    Rationale: Allowing regular users to set a network location increases the risk and attack surface.
  "
  impact 1.0
  tag cce: 'CCE-38188-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Network Connections') do
    it { should have_property 'NC_StdDomainUserSetLocation' }
    its('NC_StdDomainUserSetLocation') { should cmp == 1 }
  end
end

control '18.5.14.1_L1_Ensure_Hardened_UNC_Paths_is_set_to_Enabled_with_Require_Mutual_Authentication_and_Require_Integrity_set_for_all_NETLOGON_and_SYSVOL_shares' do
  title "(L1) Ensure 'Hardened UNC Paths' is set to 'Enabled, with \"Require Mutual Authentication\" and \"Require Integrity\" set for all NETLOGON and SYSVOL shares'"
  desc  "
    This policy setting configures secure access to UNC paths.

    The recommended state for this setting is: Enabled, with \"Require Mutual Authentication\" and \"Require Integrity\" set for all NETLOGON and SYSVOL shares.

    **Note:** If the environment exclusively contains Windows 8.0 / Server 2012 (non-R2) or newer systems, then the \"Privacy\" setting may (optionally) also be set to enable SMB encryption. However, using SMB encryption will render the targeted share paths completely inaccessible by older OSes, so only use this additional option with caution and thorough testing.

    Rationale: In February 2015, Microsoft released a new control mechanism to mitigate a security risk in Group Policy as part of the [MS15-011](https://technet.microsoft.com/library/security/MS15-011) / [MSKB 3000483](https://support.microsoft.com/en-us/kb/3000483) security update. This mechanism requires both the installation of the new security update and also the deployment of specific group policy settings to all computers on the domain from Windows Vista / Server 2008 (non-R2) or newer (the associated security patch to enable this feature was not released for Server 2003). A new group policy template (NetworkProvider.admx/adml) was also provided with the security update.

    Once the new GPO template is in place, the following are the minimum requirements to remediate the Group Policy security risk:

    \\\\*\\NETLOGON RequireMutualAuthentication=1, RequireIntegrity=1

    \\\\*\\SYSVOL RequireMutualAuthentication=1, RequireIntegrity=1

    **Note:** A reboot may be required after the setting is applied to a client machine to access the above paths.

    Additional guidance on the deployment of this security setting is available from the Microsoft Premier Field Engineering (PFE) Platforms TechNet Blog here: [Guidance on Deployment of MS15-011 and MS15-014](http://blogs.technet.com/b/askpfeplat/archive/2015/02/23/guidance-on-deployment-of-ms15-011-and-ms15-014.aspx).
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\NetworkProvider\\HardenedPaths') do
    it { should have_property '\\\\*\\NETLOGON' }
    its('\\\\*\\NETLOGON') do
      should match(/[Rr]equire([Mm]utual[Aa]uthentication|[Ii]ntegrity)=1.*[Rr]equire([Mm]utual[Aa]uthentication|[Ii]ntegrity)=1/)
    end
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\NetworkProvider\\HardenedPaths') do
    it { should have_property '\\\\*\\SYSVOL' }
    its('\\\\*\\SYSVOL') do
      should match(/[Rr]equire([Mm]utual[Aa]uthentication|[Ii]ntegrity)=1.*[Rr]equire([Mm]utual[Aa]uthentication|[Ii]ntegrity)=1/)
    end
  end
end

control '18.5.21.1_L1_Ensure_Minimize_the_number_of_simultaneous_connections_to_the_Internet_or_a_Windows_Domain_is_set_to_Enabled' do
  title "(L1) Ensure 'Minimize the number of simultaneous connections to the Internet or a Windows Domain' is set to 'Enabled'"
  desc  "
    This policy setting prevents computers from establishing multiple simultaneous connections to either the Internet or to a Windows domain.

    The recommended state for this setting is: Enabled.

    Rationale: Blocking simultaneous connections can help prevent a user unknowingly allowing network traffic to flow between the Internet and the enterprise managed network.
  "
  impact 1.0
  tag cce: 'CCE-38338-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WcmSvc\\GroupPolicy') do
    it { should have_property 'fMinimizeConnections' }
    its('fMinimizeConnections') { should cmp == 1 }
  end
end

control '18.8.3.1_L1_Ensure_Include_command_line_in_process_creation_events_is_set_to_Disabled' do
  title "(L1) Ensure 'Include command line in process creation events' is set to 'Disabled'"
  desc  "
    This policy setting determines what information is logged in security audit events when a new process has been created.

    The recommended state for this setting is: Disabled.

    Rationale: When this policy setting is enabled, any user who has read access to the security events can read the command-line arguments for any successfully created process. Command-line arguments may contain sensitive or private information such as passwords or user data.
  "
  impact 1.0
  tag cce: 'CCE-36925-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\Audit') do
    it { should have_property 'ProcessCreationIncludeCmdLine_Enabled' }
    its('ProcessCreationIncludeCmdLine_Enabled') { should cmp == 0 }
  end
end

control '18.8.4.1_L1_Ensure_Remote_host_allows_delegation_of_non-exportable_credentials_is_set_to_Enabled' do
  title "(L1) Ensure 'Remote host allows delegation of non-exportable credentials' is set to 'Enabled'"
  desc  "
    Remote host allows delegation of non-exportable credentials. When using credential delegation, devices provide an exportable version of credentials to the remote host. This exposes users to the risk of credential theft from attackers on the remote host. The Restricted Admin Mode and Windows Defender Remote Credential Guard features are two options to help protect against this risk.

    The recommended state for this setting is: Enabled.

    **Note:** More detailed information on Windows Defender Remote Credential Guard and how it compares to Restricted Admin Mode can be found at this link: [Protect Remote Desktop credentials with Windows Defender Remote Credential Guard (Windows 10) | Microsoft Docs](https://docs.microsoft.com/en-us/windows/access-protection/remote-credential-guard)

    Rationale: **Restricted Admin Mode** was designed to help protect administrator accounts by ensuring that reusable credentials are not stored in memory on remote devices that could potentially be compromised. **Windows Defender Remote Credential Guard** helps you protect your credentials over a Remote Desktop connection by redirecting Kerberos requests back to the device that is requesting the connection. Both features should be enabled and supported, as they reduce the chance of credential theft.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\CredentialsDelegation') do
    it { should have_property 'AllowProtectedCreds' }
    its('AllowProtectedCreds') { should cmp == 1 }
  end
end

control '18.8.14.1_L1_Ensure_Boot-Start_Driver_Initialization_Policy_is_set_to_Enabled_Good_unknown_and_bad_but_critical' do
  title "(L1) Ensure 'Boot-Start Driver Initialization Policy' is set to 'Enabled: Good, unknown and bad but critical'"
  desc  "
    This policy setting allows you to specify which boot-start drivers are initialized based on a classification determined by an Early Launch Antimalware boot-start driver. The Early Launch Antimalware boot-start driver can return the following classifications for each boot-start driver:

    * Good: The driver has been signed and has not been tampered with.
    * Bad: The driver has been identified as malware. It is recommended that you do not allow known bad drivers to be initialized.
    * Bad, but required for boot: The driver has been identified as malware, but the computer cannot successfully boot without loading this driver.
    * Unknown: This driver has not been attested to by your malware detection application and has not been classified by the Early Launch Antimalware boot-start driver.
    If you enable this policy setting you will be able to choose which boot-start drivers to initialize the next time the computer is started.

    If your malware detection application does not include an Early Launch Antimalware boot-start driver or if your Early Launch Antimalware boot-start driver has been disabled, this setting has no effect and all boot-start drivers are initialized.

    The recommended state for this setting is: Enabled: Good, unknown and bad but critical.

    Rationale: This policy setting helps reduce the impact of malware that has already infected your system.
  "
  impact 1.0
  tag cce: 'CCE-37912-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Policies\\EarlyLaunch') do
    it { should have_property 'DriverLoadPolicy' }
    its('DriverLoadPolicy') { should cmp == 3 }
  end
end

control '18.8.21.2_L1_Ensure_Configure_registry_policy_processing_Do_not_apply_during_periodic_background_processing_is_set_to_Enabled_FALSE' do
  title "(L1) Ensure 'Configure registry policy processing: Do not apply during periodic background processing' is set to 'Enabled: FALSE'"
  desc  "
    The \"Do not apply during periodic background processing\" option prevents the system from updating affected policies in the background while the computer is in use. When background updates are disabled, policy changes will not take effect until the next user logon or system restart.

    The recommended state for this setting is: Enabled: FALSE (unchecked).

    Rationale: Setting this option to false (unchecked) will ensure that domain policy changes take effect more quickly, as compared to waiting until the next user logon or system restart.
  "
  impact 1.0
  tag cce: 'CCE-36169-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Group Policy\\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}') do
    it { should have_property 'NoBackgroundPolicy' }
    its('NoBackgroundPolicy') { should cmp == 0 }
  end
end

control '18.8.21.3_L1_Ensure_Configure_registry_policy_processing_Process_even_if_the_Group_Policy_objects_have_not_changed_is_set_to_Enabled_TRUE' do
  title "(L1) Ensure 'Configure registry policy processing: Process even if the Group Policy objects have not changed' is set to 'Enabled: TRUE'"
  desc  "
    The \"Process even if the Group Policy objects have not changed\" option updates and reapplies policies even if the policies have not changed.

    The recommended state for this setting is: Enabled: TRUE (checked).

    Rationale: Setting this option to true (checked) will ensure unauthorized changes that might have been configured locally are forced to match the domain-based Group Policy settings again.
  "
  impact 1.0
  tag cce: 'CCE-36169-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Group Policy\\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}') do
    it { should have_property 'NoGPOListChanges' }
    its('NoGPOListChanges') { should cmp == 0 }
  end
end

control '18.8.21.4_L1_Ensure_Continue_experiences_on_this_device_is_set_to_Disabled' do
  title "(L1) Ensure 'Continue experiences on this device' is set to 'Disabled'"
  desc  "
    This policy setting determines whether the Windows device is allowed to participate in cross-device experiences (continue experiences).

    The recommended state for this setting is: Disabled.

    Rationale: A cross-device experience is when a system can access app and send messages to other devices. In an enterprise managed environment only trusted systems should be communicating within the network. Access to any other system should be prohibited.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'EnableCdp' }
    its('EnableCdp') { should cmp == 0 }
  end
end

control '18.8.21.5_L1_Ensure_Turn_off_background_refresh_of_Group_Policy_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn off background refresh of Group Policy' is set to 'Disabled'"
  desc  "
    This policy setting prevents Group Policy from being updated while the computer is in use. This policy setting applies to Group Policy for computers, users and Domain Controllers.

    The recommended state for this setting is: Disabled.

    Rationale: This setting ensures that group policy changes take effect more quickly, as compared to waiting until the next user logon or system restart.
  "
  impact 1.0
  tag cce: 'CCE-37712-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should_not have_property 'DisableBkGndGroupPolicy' }
  end
end

control '18.8.22.1.1_L1_Ensure_Turn_off_downloading_of_print_drivers_over_HTTP_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn off downloading of print drivers over HTTP' is set to 'Enabled'"
  desc  "
    This policy setting controls whether the computer can download print driver packages over HTTP. To set up HTTP printing, printer drivers that are not available in the standard operating system installation might need to be downloaded over HTTP.

    The recommended state for this setting is: Enabled.

    Rationale: Users might download drivers that include malicious code.
  "
  impact 1.0
  tag cce: 'CCE-36625-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows NT\\Printers') do
    it { should have_property 'DisableWebPnPDownload' }
    its('DisableWebPnPDownload') { should cmp == 1 }
  end
end

control '18.8.22.1.5_L1_Ensure_Turn_off_Internet_download_for_Web_publishing_and_online_ordering_wizards_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn off Internet download for Web publishing and online ordering wizards' is set to 'Enabled'"
  desc  "
    This policy setting controls whether Windows will download a list of providers for the Web publishing and online ordering wizards.

    The recommended state for this setting is: Enabled.

    Rationale: Although the risk is minimal, enabling this setting will reduce the possibility of a user unknowingly downloading malicious content through this feature.
  "
  impact 1.0
  tag cce: 'CCE-36096-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer') do
    it { should have_property 'NoWebServices' }
    its('NoWebServices') { should cmp == 1 }
  end
end

control '18.8.22.1.6_L1_Ensure_Turn_off_printing_over_HTTP_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn off printing over HTTP' is set to 'Enabled'"
  desc  "
    This policy setting allows you to disable the client computer's ability to print over HTTP, which allows the computer to print to printers on the intranet as well as the Internet.

    The recommended state for this setting is: Enabled.

    Rationale: Information that is transmitted over HTTP through this capability is not protected and can be intercepted by malicious users. For this reason, it is not often used in enterprise managed environments.
  "
  impact 1.0
  tag cce: 'CCE-36920-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows NT\\Printers') do
    it { should have_property 'DisableHTTPPrinting' }
    its('DisableHTTPPrinting') { should cmp == 1 }
  end
end

control '18.8.27.1_L1_Ensure_Block_user_from_showing_account_details_on_sign-in_is_set_to_Enabled' do
  title "(L1) Ensure 'Block user from showing account details on sign-in' is set to 'Enabled'"
  desc  "
    This policy prevents the user from showing account details (email address or user name) on the sign-in screen.

    The recommended state for this setting is: Enabled.

    Rationale: An attacker with access to the console (for example, someone with physical access or someone who is able to connect to the server through Remote Desktop Services) could view the name of the last user who logged on to the server. The attacker could then try to guess the password, use a dictionary, or use a brute-force attack to try and log on.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'BlockUserFromShowingAccountDetailsOnSignin' }
    its('BlockUserFromShowingAccountDetailsOnSignin') { should cmp == 1 }
  end
end

control '18.8.27.2_L1_Ensure_Do_not_display_network_selection_UI_is_set_to_Enabled' do
  title "(L1) Ensure 'Do not display network selection UI' is set to 'Enabled'"
  desc  "
    This policy setting allows you to control whether anyone can interact with available networks UI on the logon screen.

    The recommended state for this setting is: Enabled.

    Rationale: An unauthorized user could disconnect the PC from the network or can connect the PC to other available networks without signing into Windows.
  "
  impact 1.0
  tag cce: 'CCE-38353-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'DontDisplayNetworkSelectionUI' }
    its('DontDisplayNetworkSelectionUI') { should cmp == 1 }
  end
end

control '18.8.27.3_L1_Ensure_Do_not_enumerate_connected_users_on_domain-joined_computers_is_set_to_Enabled' do
  title "(L1) Ensure 'Do not enumerate connected users on domain-joined computers' is set to 'Enabled'"
  desc  "
    This policy setting prevents connected users from being enumerated on domain-joined computers.

    The recommended state for this setting is: Enabled.

    Rationale: A malicious user could use this feature to gather account names of other users, that information could then be used in conjunction with other types of attacks such as guessing passwords or social engineering. The value of this countermeasure is small because a user with domain credentials could gather the same account information using other methods.
  "
  impact 1.0
  tag cce: 'CCE-37838-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'DontEnumerateConnectedUsers' }
    its('DontEnumerateConnectedUsers') { should cmp == 1 }
  end
end

control '18.8.27.5_L1_Ensure_Turn_off_app_notifications_on_the_lock_screen_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn off app notifications on the lock screen' is set to 'Enabled'"
  desc  "
    This policy setting allows you to prevent app notifications from appearing on the lock screen.

    The recommended state for this setting is: Enabled.

    Rationale: App notifications might display sensitive business or personal data.
  "
  impact 1.0
  tag cce: 'CCE-35893-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'DisableLockScreenAppNotifications' }
    its('DisableLockScreenAppNotifications') { should cmp == 1 }
  end
end

control '18.8.27.6_L1_Ensure_Turn_off_picture_password_sign-in_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn off picture password sign-in' is set to 'Enabled'"
  desc  "
    This policy setting allows you to control whether a domain user can sign in using a picture password.

    The recommended state for this setting is: Enabled.

    **Note:** If the picture password feature is permitted, the user's domain password is cached in the system vault when using it.

    Rationale: Picture passwords bypass the requirement for a typed complex password. In a shared work environment, a simple shoulder surf where someone observed the on-screen gestures would allow that person to gain access to the system without the need to know the complex password. Vertical monitor screens with an image are much more visible at a distance than horizontal key strokes, increasing the likelihood of a successful observation of the mouse gestures.
  "
  impact 1.0
  tag cce: 'CCE-37830-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'BlockDomainPicturePassword' }
    its('BlockDomainPicturePassword') { should cmp == 1 }
  end
end

control '18.8.27.7_L1_Ensure_Turn_on_convenience_PIN_sign-in_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn on convenience PIN sign-in' is set to 'Disabled'"
  desc  "
    This policy setting allows you to control whether a domain user can sign in using a convenience PIN. In Windows 10, convenience PIN was replaced with Passport, which has stronger security properties. To configure Passport for domain users, use the policies under Computer Configuration\\Administrative Templates\\Windows Components\\Microsoft Passport for Work.

    **Note:** The user's domain password will be cached in the system vault when using this feature.

    The recommended state for this setting is: Disabled.

    Rationale: A PIN is created from a much smaller selection of characters than a password, so in most cases a PIN will be much less robust than a password.
  "
  impact 1.0
  tag cce: 'CCE-37528-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'AllowDomainPINLogon' }
    its('AllowDomainPINLogon') { should cmp == 0 }
  end
end

control '18.8.28.1_L1_Ensure_Untrusted_Font_Blocking_is_set_to_Enabled_Block_untrusted_fonts_and_log_events' do
  title "(L1) Ensure 'Untrusted Font Blocking' is set to 'Enabled: Block untrusted fonts and log events'"
  desc  "
    This security feature provides a global setting to prevent programs from loading untrusted fonts. Untrusted fonts are any font installed outside of the %windir%\\Fonts directory. This feature can be configured to be in 3 modes: On, Off, and Audit.

    The recommended state for this setting is: Enabled: Block untrusted fonts and log events

    Rationale: Blocking untrusted fonts helps prevent both remote (web-based or email-based) and local EOP attacks that can happen during the font file-parsing process.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\MitigationOptions') do
    it { should have_property 'MitigationOptions_FontBocking' }
    its('MitigationOptions_FontBocking') { should eq '1000000000000' }
  end
end

control '18.8.33.6.3_L1_Ensure_Require_a_password_when_a_computer_wakes_on_battery_is_set_to_Enabled' do
  title "(L1) Ensure 'Require a password when a computer wakes (on battery)' is set to 'Enabled'"
  desc  "
    Specifies whether or not the user is prompted for a password when the system resumes from sleep.

    The recommended state for this setting is: Enabled.

    Rationale: Enabling this setting ensures that anyone who wakes an unattended computer from sleep state will have to provide logon credentials before they can access the system.
  "
  impact 1.0
  tag cce: 'CCE-36881-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Power\\PowerSettings\\0e796bdb-100d-47d6-a2d5-f7d2daa51f51') do
    it { should have_property 'DCSettingIndex' }
    its('DCSettingIndex') { should cmp == 1 }
  end
end

control '18.8.33.6.4_L1_Ensure_Require_a_password_when_a_computer_wakes_plugged_in_is_set_to_Enabled' do
  title "(L1) Ensure 'Require a password when a computer wakes (plugged in)' is set to 'Enabled'"
  desc  "
    Specifies whether or not the user is prompted for a password when the system resumes from sleep.

    The recommended state for this setting is: Enabled.

    Rationale: Enabling this setting ensures that anyone who wakes an unattended computer from sleep state will have to provide logon credentials before they can access the system.
  "
  impact 1.0
  tag cce: 'CCE-37066-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Power\\PowerSettings\\0e796bdb-100d-47d6-a2d5-f7d2daa51f51') do
    it { should have_property 'ACSettingIndex' }
    its('ACSettingIndex') { should cmp == 1 }
  end
end

control '18.8.35.1_L1_Ensure_Configure_Offer_Remote_Assistance_is_set_to_Disabled' do
  title "(L1) Ensure 'Configure Offer Remote Assistance' is set to 'Disabled'"
  desc  "
    This policy setting allows you to turn on or turn off Offer (Unsolicited) Remote Assistance on this computer.

    Help desk and support personnel will not be able to proactively offer assistance, although they can still respond to user assistance requests.

    The recommended state for this setting is: Disabled.

    Rationale: A user might be tricked and accept an unsolicited Remote Assistance offer from a malicious user.
  "
  impact 1.0
  tag cce: 'CCE-36388-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'fAllowUnsolicited' }
    its('fAllowUnsolicited') { should cmp == 0 }
  end
end

control '18.8.35.2_L1_Ensure_Configure_Solicited_Remote_Assistance_is_set_to_Disabled' do
  title "(L1) Ensure 'Configure Solicited Remote Assistance' is set to 'Disabled'"
  desc  "
    This policy setting allows you to turn on or turn off Solicited (Ask for) Remote Assistance on this computer.

    The recommended state for this setting is: Disabled.

    Rationale: There is slight risk that a rogue administrator will gain access to another user's desktop session, however, they cannot connect to a user's computer unannounced or control it without permission from the user. When an expert tries to connect, the user can still choose to deny the connection or give the expert view-only privileges. The user must explicitly click the Yes button to allow the expert to remotely control the workstation.
  "
  impact 1.0
  tag cce: 'CCE-37281-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'fAllowToGetHelp' }
    its('fAllowToGetHelp') { should cmp == 0 }
  end
end

control '18.9.6.1_L1_Ensure_Allow_Microsoft_accounts_to_be_optional_is_set_to_Enabled' do
  title "(L1) Ensure 'Allow Microsoft accounts to be optional' is set to 'Enabled'"
  desc  "
    This policy setting lets you control whether Microsoft accounts are optional for Windows Store apps that require an account to sign in. This policy only affects Windows Store apps that support it.

    The recommended state for this setting is: Enabled.

    Rationale: Enabling this setting allows an organization to use their enterprise user accounts instead of using their Microsoft accounts when accessing Windows store apps. This provides the organization with greater control over relevant credentials. Microsoft accounts cannot be centrally managed and as such enterprise credential security policies cannot be applied to them, which could put any information accessed by using Microsoft accounts at risk.
  "
  impact 1.0
  tag cce: 'CCE-38354-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'MSAOptional' }
    its('MSAOptional') { should cmp == 1 }
  end
end

control '18.9.8.1_L1_Ensure_Disallow_Autoplay_for_non-volume_devices_is_set_to_Enabled' do
  title "(L1) Ensure 'Disallow Autoplay for non-volume devices' is set to 'Enabled'"
  desc  "
    This policy setting disallows AutoPlay for MTP devices like cameras or phones.

    The recommended state for this setting is: Enabled.

    Rationale: An attacker could use this feature to launch a program to damage a client computer or data on the computer.
  "
  impact 1.0
  tag cce: 'CCE-37636-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Explorer') do
    it { should have_property 'NoAutoplayfornonVolume' }
    its('NoAutoplayfornonVolume') { should cmp == 1 }
  end
end

control '18.9.8.2_L1_Ensure_Set_the_default_behavior_for_AutoRun_is_set_to_Enabled_Do_not_execute_any_autorun_commands' do
  title "(L1) Ensure 'Set the default behavior for AutoRun' is set to 'Enabled: Do not execute any autorun commands'"
  desc  "
    This policy setting sets the default behavior for Autorun commands. Autorun commands are generally stored in autorun.inf files. They often launch the installation program or other routines.

    The recommended state for this setting is: Enabled: Do not execute any autorun commands.

    Rationale: Prior to Windows Vista, when media containing an autorun command is inserted, the system will automatically execute the program without user intervention. This creates a major security concern as code may be executed without user's knowledge. The default behavior starting with Windows Vista is to prompt the user whether autorun command is to be run. The autorun command is represented as a handler in the Autoplay dialog.
  "
  impact 1.0
  tag cce: 'CCE-38217-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer') do
    it { should have_property 'NoAutorun' }
    its('NoAutorun') { should cmp == 1 }
  end
end

control '18.9.8.3_L1_Ensure_Turn_off_Autoplay_is_set_to_Enabled_All_drives' do
  title "(L1) Ensure 'Turn off Autoplay' is set to 'Enabled: All drives'"
  desc  "
    Autoplay starts to read from a drive as soon as you insert media in the drive, which causes the setup file for programs or audio media to start immediately. An attacker could use this feature to launch a program to damage the computer or data on the computer. Autoplay is disabled by default on some removable drive types, such as floppy disk and network drives, but not on CD-ROM drives.

    **Note:** You cannot use this policy setting to enable Autoplay on computer drives in which it is disabled by default, such as floppy disk and network drives.

    The recommended state for this setting is: Enabled: All drives.

    Rationale: An attacker could use this feature to launch a program to damage a client computer or data on the computer.
  "
  impact 1.0
  tag cce: 'CCE-36875-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer') do
    it { should have_property 'NoDriveTypeAutoRun' }
    its('NoDriveTypeAutoRun') { should cmp == 255 }
  end
end

control '18.9.10.1.1_L1_Ensure_Configure_enhanced_anti-spoofing_is_set_to_Enabled' do
  title "(L1) Ensure 'Configure enhanced anti-spoofing' is set to 'Enabled'"
  desc  "
    This policy setting determines whether enhanced anti-spoofing is configured for devices which support it.

    The recommended state for this setting is: Enabled.

    Rationale: Enterprise managed environments are now supporting a wider range of mobile devices, increasing the security on these devices will help protect against unauthorized access on your network.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Biometrics\\FacialFeatures') do
    it { should have_property 'EnhancedAntiSpoofing' }
    its('EnhancedAntiSpoofing') { should cmp == 1 }
  end
end

control '18.9.13.1_L1_Ensure_Turn_off_Microsoft_consumer_experiences_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn off Microsoft consumer experiences' is set to 'Enabled'"
  desc  "
    This policy setting turns off experiences that help consumers make the most of their devices and Microsoft account.

    The recommended state for this setting is: Enabled.

    **Note:**[Per Microsoft TechNet](https://technet.microsoft.com/en-us/itpro/windows/manage/group-policies-for-enterprise-and-education-editions), this policy setting only applies to Windows 10 Enterprise and Windows 10 Education editions.

    Rationale: Having apps silently install in an enterprise managed environment is not good security practice - especially if the apps send data back to a 3rd party.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\CloudContent') do
    it { should have_property 'DisableWindowsConsumerFeatures' }
    its('DisableWindowsConsumerFeatures') { should cmp == 1 }
  end
end

control '18.9.14.1_L1_Ensure_Require_pin_for_pairing_is_set_to_Enabled' do
  title "(L1) Ensure 'Require pin for pairing' is set to 'Enabled'"
  desc  "
    This policy setting controls whether or not a PIN is required for pairing to a wireless display device.

    The recommended state for this setting is: Enabled.

    Rationale: If this setting is not configured or disabled then a PIN would not be required when pairing wireless display devices to the system, increasing the risk of unauthorized use.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Connect') do
    it { should have_property 'RequirePinForPairing' }
    its('RequirePinForPairing') { should cmp == 1 }
  end
end

control '18.9.15.1_L1_Ensure_Do_not_display_the_password_reveal_button_is_set_to_Enabled' do
  title "(L1) Ensure 'Do not display the password reveal button' is set to 'Enabled'"
  desc  "
    This policy setting allows you to configure the display of the password reveal button in password entry user experiences.

    The recommended state for this setting is: Enabled.

    Rationale: This is a useful feature when entering a long and complex password, especially when using a touchscreen. The potential risk is that someone else may see your password while surreptitiously observing your screen.
  "
  impact 1.0
  tag cce: 'CCE-37534-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\CredUI') do
    it { should have_property 'DisablePasswordReveal' }
    its('DisablePasswordReveal') { should cmp == 1 }
  end
end

control '18.9.15.2_L1_Ensure_Enumerate_administrator_accounts_on_elevation_is_set_to_Disabled' do
  title "(L1) Ensure 'Enumerate administrator accounts on elevation' is set to 'Disabled'"
  desc  "
    This policy setting controls whether administrator accounts are displayed when a user attempts to elevate a running application.

    The recommended state for this setting is: Disabled.

    Rationale: Users could see the list of administrator accounts, making it slightly easier for a malicious user who has logged onto a console session to try to crack the passwords of those accounts.
  "
  impact 1.0
  tag cce: 'CCE-36512-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\CredUI') do
    it { should have_property 'EnumerateAdministrators' }
    its('EnumerateAdministrators') { should cmp == 0 }
  end
end

control '18.9.16.1_L1_Ensure_Allow_Telemetry_is_set_to_Enabled_0_-_Security_Enterprise_Only_or_Enabled_1_-_Basic' do
  title "(L1) Ensure 'Allow Telemetry' is set to 'Enabled: 0 - Security [Enterprise Only]' or 'Enabled: 1 - Basic'"
  desc  "
    This policy setting determines the amount of diagnostic and usage data reported to Microsoft:

    * A value of 0 - Security [Enterprise Only] will send minimal data to Microsoft. This data includes Malicious Software Removal Tool (MSRT)  Windows Defender data, if enabled, and telemetry client settings. Setting a value of 0 applies to enterprise, EDU, IoT and server devices only. Setting a value of 0 for other devices is equivalent to choosing a value of 1.
    * A value of 1 - Basic sends only a basic amount of diagnostic and usage data. Note that setting values of 0 or 1 will degrade certain experiences on the device.
    * A value of 2 - Enhanced sends enhanced diagnostic and usage data.
    * A value of 3 - Full sends the same data as a value of 2, plus additional diagnostics data, including the files and content that may have caused the problem.
    Windows 10 telemetry settings apply to the Windows operating system and some first party apps. This setting does not apply to third party apps running on Windows 10.

    The recommended state for this setting is: Enabled: 0 - Security [Enterprise Only] or Enabled: 1 - Basic.

    **Note:** If the **Allow Telemetry** setting is configured to 0 - Security [Enterprise Only], then the options in Windows Update to defer upgrades and updates will have no effect.

    **Note #2:** In the Microsoft Windows 10 RTM (Release 1507) Administrative Templates, the zero value was named 0 - Off [Enterprise Only], but it was renamed to 0 - Security [Enterprise Only] starting with the Windows 10 Release 1511 Administrative Templates.

    Rationale: Sending any data to a 3rd party vendor is a security concern and should only be done on an as needed basis.
  "
  impact 1.0
  describe.one do
    describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\DataCollection') do
      it { should have_property 'AllowTelemetry' }
      its('AllowTelemetry') { should cmp == 0 }
    end
    describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\DataCollection') do
      it { should have_property 'AllowTelemetry' }
      its('AllowTelemetry') { should cmp == 1 }
    end
  end
end

control '18.9.16.3_L1_Ensure_Disable_pre-release_features_or_settings_is_set_to_Disabled' do
  title "(L1) Ensure 'Disable pre-release features or settings' is set to 'Disabled'"
  desc  "
    This policy setting determines the level that Microsoft can experiment with the product to study user preferences or device behavior. A value of 1 permits Microsoft to configure device settings only. A value of 2 allows Microsoft to conduct full experimentations.

    The recommended state for this setting is: Disabled.

    **Note:** Although the setting of Disabled seems counter-intuitive (disabling a Disable setting is a double negative, which should mean Enable), this setting is incorrectly worded in the Microsoft templates. Configuring Disabled does indeed achieve the desired result of disabling the pre-release features and settings.

    Rationale: It can be dangerous in an enterprise managed environment if experimental features are allowed because this can introduce bugs and security holes into systems, making it easier for an attacker to gain access.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\PreviewBuilds') do
    it { should have_property 'EnableConfigFlighting' }
    its('EnableConfigFlighting') { should cmp == 0 }
  end
end

control '18.9.16.4_L1_Ensure_Do_not_show_feedback_notifications_is_set_to_Enabled' do
  title "(L1) Ensure 'Do not show feedback notifications' is set to 'Enabled'"
  desc  "
    This policy setting allows an organization to prevent its devices from showing feedback questions from Microsoft.

    The recommended state for this setting is: Enabled.

    Rationale: Users should not be sending any feedback to 3rd party vendors in an enterprise managed environment.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\DataCollection') do
    it { should have_property 'DoNotShowFeedbackNotifications' }
    its('DoNotShowFeedbackNotifications') { should cmp == 1 }
  end
end

control '18.9.16.5_L1_Ensure_Toggle_user_control_over_Insider_builds_is_set_to_Disabled' do
  title "(L1) Ensure 'Toggle user control over Insider builds' is set to 'Disabled'"
  desc  "
    This policy setting determines whether users can access the Insider build controls in the Advanced Options for Windows Update. These controls are located under \"Get Insider builds,\" and enable users to make their devices available for downloading and installing Windows preview software.

    The recommended state for this setting is: Disabled.

    **Note:** This policy setting applies only to devices running Windows Server 2016, up until Release 1703. For Release 1709 or newer, Microsoft encourages using the Manage preview builds setting (Rule 18.9.101.1.1). We have kept this setting in the benchmark to ensure that any older builds of Windows Server 2016 in the environment are still enforced.

    Rationale: It can be risky for experimental features to be allowed in an enterprise managed environment because this can introduce bugs and security holes into systems, making it easier for an attacker to gain access. It is generally preferred to only use production-ready builds.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\PreviewBuilds') do
    it { should have_property 'AllowBuildPreview' }
    its('AllowBuildPreview') { should cmp == 0 }
  end
end

control '18.9.26.1.1_L1_Ensure_Application_Control_Event_Log_behavior_when_the_log_file_reaches_its_maximum_size_is_set_to_Disabled' do
  title "(L1) Ensure 'Application: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'"
  desc  "
    This policy setting controls Event Log behavior when the log file reaches its maximum size.

    The recommended state for this setting is: Disabled.

    **Note:** Old events may or may not be retained according to the **Backup log automatically when full** policy setting.

    Rationale: If new events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users.
  "
  impact 1.0
  tag cce: 'CCE-37775-4'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Application') do
    it { should have_property 'Retention' }
    its('Retention') { should cmp == 0 }
  end
end

control '18.9.26.1.2_L1_Ensure_Application_Specify_the_maximum_log_file_size_KB_is_set_to_Enabled_32768_or_greater' do
  title "(L1) Ensure 'Application: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater'"
  desc  "
    This policy setting specifies the maximum size of the log file in kilobytes. The maximum log file size can be configured between 1 megabyte (1,024 kilobytes) and 4 terabytes (4,194,240 kilobytes) in kilobyte increments.

    The recommended state for this setting is: Enabled: 32,768 or greater.

    Rationale: If events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users.
  "
  impact 1.0
  tag cce: 'CCE-37948-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Application') do
    it { should have_property 'MaxSize' }
    its('MaxSize') { should cmp >= 32_768 }
  end
end

control '18.9.26.2.1_L1_Ensure_Security_Control_Event_Log_behavior_when_the_log_file_reaches_its_maximum_size_is_set_to_Disabled' do
  title "(L1) Ensure 'Security: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'"
  desc  "
    This policy setting controls Event Log behavior when the log file reaches its maximum size.

    The recommended state for this setting is: Disabled.

    **Note:** Old events may or may not be retained according to the **Backup log automatically when full** policy setting.

    Rationale: If new events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users.
  "
  impact 1.0
  tag cce: 'CCE-37145-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Security') do
    it { should have_property 'Retention' }
    its('Retention') { should cmp == 0 }
  end
end

control '18.9.26.2.2_L1_Ensure_Security_Specify_the_maximum_log_file_size_KB_is_set_to_Enabled_196608_or_greater' do
  title "(L1) Ensure 'Security: Specify the maximum log file size (KB)' is set to 'Enabled: 196,608 or greater'"
  desc  "
    This policy setting specifies the maximum size of the log file in kilobytes. The maximum log file size can be configured between 1 megabyte (1,024 kilobytes) and 4 terabytes (4,194,240 kilobytes) in kilobyte increments.

    The recommended state for this setting is: Enabled: 196,608 or greater.

    Rationale: If events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users.
  "
  impact 1.0
  tag cce: 'CCE-37695-4'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Security') do
    it { should have_property 'MaxSize' }
    its('MaxSize') { should cmp >= 196_608 }
  end
end

control '18.9.26.3.1_L1_Ensure_Setup_Control_Event_Log_behavior_when_the_log_file_reaches_its_maximum_size_is_set_to_Disabled' do
  title "(L1) Ensure 'Setup: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'"
  desc  "
    This policy setting controls Event Log behavior when the log file reaches its maximum size.

    The recommended state for this setting is: Disabled.

    **Note:** Old events may or may not be retained according to the **Backup log automatically when full** policy setting.

    Rationale: If new events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users.
  "
  impact 1.0
  tag cce: 'CCE-38276-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Setup') do
    it { should have_property 'Retention' }
    its('Retention') { should cmp == 0 }
  end
end

control '18.9.26.3.2_L1_Ensure_Setup_Specify_the_maximum_log_file_size_KB_is_set_to_Enabled_32768_or_greater' do
  title "(L1) Ensure 'Setup: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater'"
  desc  "
    This policy setting specifies the maximum size of the log file in kilobytes. The maximum log file size can be configured between 1 megabyte (1,024 kilobytes) and 4 terabytes (4,194,240 kilobytes) in kilobyte increments.

    The recommended state for this setting is: Enabled: 32,768 or greater.

    Rationale: If events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users
  "
  impact 1.0
  tag cce: 'CCE-37526-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Setup') do
    it { should have_property 'MaxSize' }
    its('MaxSize') { should cmp >= 32_768 }
  end
end

control '18.9.26.4.1_L1_Ensure_System_Control_Event_Log_behavior_when_the_log_file_reaches_its_maximum_size_is_set_to_Disabled' do
  title "(L1) Ensure 'System: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'"
  desc  "
    This policy setting controls Event Log behavior when the log file reaches its maximum size.

    The recommended state for this setting is: Disabled.

    **Note:** Old events may or may not be retained according to the **Backup log automatically when full** policy setting.

    Rationale: If new events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users.
  "
  impact 1.0
  tag cce: 'CCE-36160-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\System') do
    it { should have_property 'Retention' }
    its('Retention') { should cmp == 0 }
  end
end

control '18.9.26.4.2_L1_Ensure_System_Specify_the_maximum_log_file_size_KB_is_set_to_Enabled_32768_or_greater' do
  title "(L1) Ensure 'System: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater'"
  desc  "
    This policy setting specifies the maximum size of the log file in kilobytes. The maximum log file size can be configured between 1 megabyte (1,024 kilobytes) and 4 terabytes (4,194,240 kilobytes) in kilobyte increments.

    The recommended state for this setting is: Enabled: 32,768 or greater.

    Rationale: If events are not recorded it may be difficult or impossible to determine the root cause of system problems or the unauthorized activities of malicious users
  "
  impact 1.0
  tag cce: 'CCE-36092-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\EventLog\\System') do
    it { should have_property 'MaxSize' }
    its('MaxSize') { should cmp >= 32_768 }
  end
end

control '18.9.30.2_L1_Ensure_Turn_off_Data_Execution_Prevention_for_Explorer_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn off Data Execution Prevention for Explorer' is set to 'Disabled'"
  desc  "
    Disabling Data Execution Prevention can allow certain legacy plug-in applications to function without terminating Explorer.

    The recommended state for this setting is: Disabled.

    **Note:** Some legacy plug-in applications and other software may not function with Data Execution Prevention and will require an exception to be defined for that specific plug-in/software.

    Rationale: Data Execution Prevention is an important security feature supported by Explorer that helps to limit the impact of certain types of malware.
  "
  impact 1.0
  tag cce: 'CCE-37809-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Explorer') do
    it { should have_property 'NoDataExecutionPrevention' }
    its('NoDataExecutionPrevention') { should cmp == 0 }
  end
end

control '18.9.30.3_L1_Ensure_Turn_off_heap_termination_on_corruption_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn off heap termination on corruption' is set to 'Disabled'"
  desc  "
    Without heap termination on corruption, legacy plug-in applications may continue to function when a File Explorer session has become corrupt. Ensuring that heap termination on corruption is active will prevent this.

    The recommended state for this setting is: Disabled.

    Rationale: Allowing an application to function after its session has become corrupt increases the risk posture to the system.
  "
  impact 1.0
  tag cce: 'CCE-36660-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Explorer') do
    it { should have_property 'NoHeapTerminationOnCorruption' }
    its('NoHeapTerminationOnCorruption') { should cmp == 0 }
  end
end

control '18.9.30.4_L1_Ensure_Turn_off_shell_protocol_protected_mode_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn off shell protocol protected mode' is set to 'Disabled'"
  desc  "
    This policy setting allows you to configure the amount of functionality that the shell protocol can have. When using the full functionality of this protocol, applications can open folders and launch files. The protected mode reduces the functionality of this protocol allowing applications to only open a limited set of folders. Applications are not able to open files with this protocol when it is in the protected mode. It is recommended to leave this protocol in the protected mode to increase the security of Windows.

    The recommended state for this setting is: Disabled.

    Rationale: Limiting the opening of files and folders to a limited set reduces the attack surface of the system.
  "
  impact 1.0
  tag cce: 'CCE-36809-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer') do
    it { should have_property 'PreXPSP2ShellProtocolBehavior' }
    its('PreXPSP2ShellProtocolBehavior') { should cmp == 0 }
  end
end

control '18.9.44.1_L1_Ensure_Block_all_consumer_Microsoft_account_user_authentication_is_set_to_Enabled' do
  title "(L1) Ensure 'Block all consumer Microsoft account user authentication' is set to 'Enabled'"
  desc  "
    This setting determines whether applications and services on the device can utilize new consumer Microsoft account authentication via the Windows OnlineID and WebAccountManager APIs.

    The recommended state for this setting is: Enabled.

    Rationale: Organizations that want to effectively implement identity management policies and maintain firm control of what accounts are used on their computers will probably want to block Microsoft accounts. Organizations may also need to block Microsoft accounts in order to meet the requirements of compliance standards that apply to their information systems.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\MicrosoftAccount') do
    it { should have_property 'DisableUserAuth' }
    its('DisableUserAuth') { should cmp == 1 }
  end
end

control '18.9.52.1_L1_Ensure_Prevent_the_usage_of_OneDrive_for_file_storage_is_set_to_Enabled' do
  title "(L1) Ensure 'Prevent the usage of OneDrive for file storage' is set to 'Enabled'"
  desc  "
    This policy setting lets you prevent apps and features from working with files on OneDrive using the Next Generation Sync Client.

    The recommended state for this setting is: Enabled.

    Rationale: Enabling this setting prevents users from accidentally uploading confidential or sensitive corporate information to the OneDrive cloud service using the Next Generation Sync Client.
  "
  impact 1.0
  tag cce: 'CCE-36939-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\OneDrive') do
    it { should have_property 'DisableFileSyncNGSC' }
    its('DisableFileSyncNGSC') { should cmp == 1 }
  end
end

control '18.9.58.2.2_L1_Ensure_Do_not_allow_passwords_to_be_saved_is_set_to_Enabled' do
  title "(L1) Ensure 'Do not allow passwords to be saved' is set to 'Enabled'"
  desc  "
    This policy setting helps prevent Remote Desktop clients from saving passwords on a computer.

    The recommended state for this setting is: Enabled.

    **Note:** If this policy setting was previously configured as Disabled or Not configured, any previously saved passwords will be deleted the first time a Remote Desktop client disconnects from any server.

    Rationale: An attacker with physical access to the computer may be able to break the protection guarding saved passwords. An attacker who compromises a user's account and connects to their computer could use saved passwords to gain access to additional hosts.
  "
  impact 1.0
  tag cce: 'CCE-36223-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'DisablePasswordSaving' }
    its('DisablePasswordSaving') { should cmp == 1 }
  end
end

control '18.9.58.3.3.2_L1_Ensure_Do_not_allow_drive_redirection_is_set_to_Enabled' do
  title "(L1) Ensure 'Do not allow drive redirection' is set to 'Enabled'"
  desc  "
    This policy setting prevents users from sharing the local drives on their client computers to Remote Desktop Servers that they access. Mapped drives appear in the session folder tree in Windows Explorer in the following format:

    \\\\TSClient\\
    <driveletter>$

    If local drives are shared they are left vulnerable to intruders who want to exploit the data that is stored on them.

    The recommended state for this setting is: Enabled.</driveletter>

    Rationale: Data could be forwarded from the user's Remote Desktop Services session to the user's local computer without any direct user interaction. Malicious software already present on a compromised server would have direct and stealthy disk access to the user's local computer during the Remote Desktop session.
  "
  impact 1.0
  tag cce: 'CCE-36509-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'fDisableCdm' }
    its('fDisableCdm') { should cmp == 1 }
  end
end

control '18.9.58.3.9.1_L1_Ensure_Always_prompt_for_password_upon_connection_is_set_to_Enabled' do
  title "(L1) Ensure 'Always prompt for password upon connection' is set to 'Enabled'"
  desc  "
    This policy setting specifies whether Remote Desktop Services always prompts the client computer for a password upon connection. You can use this policy setting to enforce a password prompt for users who log on to Remote Desktop Services, even if they already provided the password in the Remote Desktop Connection client.

    The recommended state for this setting is: Enabled.

    Rationale: Users have the option to store both their username and password when they create a new Remote Desktop Connection shortcut. If the server that runs Remote Desktop Services allows users who have used this feature to log on to the server but not enter their password, then it is possible that an attacker who has gained physical access to the user's computer could connect to a Remote Desktop Server through the Remote Desktop Connection shortcut, even though they may not know the user's password.
  "
  impact 1.0
  tag cce: 'CCE-37929-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'fPromptForPassword' }
    its('fPromptForPassword') { should cmp == 1 }
  end
end

control '18.9.58.3.9.2_L1_Ensure_Require_secure_RPC_communication_is_set_to_Enabled' do
  title "(L1) Ensure 'Require secure RPC communication' is set to 'Enabled'"
  desc  "
    This policy setting allows you to specify whether Remote Desktop Services requires secure Remote Procedure Call (RPC) communication with all clients or allows unsecured communication.

    You can use this policy setting to strengthen the security of RPC communication with clients by allowing only authenticated and encrypted requests.

    The recommended state for this setting is: Enabled.

    Rationale: Allowing unsecure RPC communication can exposes the server to man in the middle attacks and data disclosure attacks.
  "
  impact 1.0
  tag cce: 'CCE-37567-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'fEncryptRPCTraffic' }
    its('fEncryptRPCTraffic') { should cmp == 1 }
  end
end

control '18.9.58.3.9.3_L1_Ensure_Set_client_connection_encryption_level_is_set_to_Enabled_High_Level' do
  title "(L1) Ensure 'Set client connection encryption level' is set to 'Enabled: High Level'"
  desc  "
    This policy setting specifies whether to require the use of a specific encryption level to secure communications between client computers and RD Session Host servers during Remote Desktop Protocol (RDP) connections. This policy only applies when you are using native RDP encryption. However, native RDP encryption (as opposed to SSL encryption) is not recommended. This policy does not apply to SSL encryption.

    The recommended state for this setting is: Enabled: High Level.

    Rationale: If Remote Desktop client connections that use low level encryption are allowed, it is more likely that an attacker will be able to decrypt any captured Remote Desktop Services network traffic.
  "
  impact 1.0
  tag cce: 'CCE-36627-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'MinEncryptionLevel' }
    its('MinEncryptionLevel') { should cmp == 3 }
  end
end

control '18.9.58.3.11.1_L1_Ensure_Do_not_delete_temp_folders_upon_exit_is_set_to_Disabled' do
  title "(L1) Ensure 'Do not delete temp folders upon exit' is set to 'Disabled'"
  desc  "
    This policy setting specifies whether Remote Desktop Services retains a user's per-session temporary folders at logoff.

    The recommended state for this setting is: Disabled.

    Rationale: Sensitive information could be contained inside the temporary folders and visible to other administrators that log into the system.
  "
  impact 1.0
  tag cce: 'CCE-37946-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'DeleteTempDirsOnExit' }
    its('DeleteTempDirsOnExit') { should cmp == 1 }
  end
end

control '18.9.58.3.11.2_L1_Ensure_Do_not_use_temporary_folders_per_session_is_set_to_Disabled' do
  title "(L1) Ensure 'Do not use temporary folders per session' is set to 'Disabled'"
  desc  "
    By default, Remote Desktop Services creates a separate temporary folder on the RD Session Host server for each active session that a user maintains on the RD Session Host server. The temporary folder is created on the RD Session Host server in a Temp folder under the user's profile folder and is named with the sessionid. This temporary folder is used to store individual temporary files.

    To reclaim disk space, the temporary folder is deleted when the user logs off from a session.

    The recommended state for this setting is: Disabled.

    Rationale: Disabling this setting keeps the cached data independent for each session, both reducing the chance of problems from shared cached data between sessions, and keeping possibly sensitive data separate to each user session.
  "
  impact 1.0
  tag cce: 'CCE-38180-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows NT\\Terminal Services') do
    it { should have_property 'PerSessionTempDir' }
    its('PerSessionTempDir') { should cmp == 1 }
  end
end

control '18.9.59.1_L1_Ensure_Prevent_downloading_of_enclosures_is_set_to_Enabled' do
  title "(L1) Ensure 'Prevent downloading of enclosures' is set to 'Enabled'"
  desc  "
    This policy setting prevents the user from having enclosures (file attachments) downloaded from an RSS feed to the user's computer.

    The recommended state for this setting is: Enabled.

    Rationale: Allowing attachments to be downloaded through the RSS feed can introduce files that could have malicious intent.
  "
  impact 1.0
  tag cce: 'CCE-37126-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Internet Explorer\\Feeds') do
    it { should have_property 'DisableEnclosureDownload' }
    its('DisableEnclosureDownload') { should cmp == 1 }
  end
end

control '18.9.60.3_L1_Ensure_Allow_indexing_of_encrypted_files_is_set_to_Disabled' do
  title "(L1) Ensure 'Allow indexing of encrypted files' is set to 'Disabled'"
  desc  "
    This policy setting controls whether encrypted items are allowed to be indexed. When this setting is changed, the index is rebuilt completely. Full volume encryption (such as BitLocker Drive Encryption or a non-Microsoft solution) must be used for the location of the index to maintain security for encrypted files.

    The recommended state for this setting is: Disabled.

    Rationale: Indexing and allowing users to search encrypted files could potentially reveal confidential data stored within the encrypted files.
  "
  impact 1.0
  tag cce: 'CCE-38277-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Windows Search') do
    it { should have_property 'AllowIndexingEncryptedStoresOrItems' }
    its('AllowIndexingEncryptedStoresOrItems') { should cmp == 0 }
  end
end

control '18.9.76.3.1_L1_Ensure_Configure_local_setting_override_for_reporting_to_Microsoft_MAPS_is_set_to_Disabled' do
  title "(L1) Ensure 'Configure local setting override for reporting to Microsoft MAPS' is set to 'Disabled'"
  desc  "
    This policy setting configures a local override for the configuration to join Microsoft Active Protection Service (MAPS), which Microsoft has now renamed to \"Windows Defender Antivirus Cloud Protection Service\". This setting can only be set by Group Policy.

    The recommended state for this setting is: Disabled.

    Rationale: The decision on whether or not to participate in Microsoft MAPS / Windows Defender Antivirus Cloud Protection Service for malicious software reporting should be made centrally in an enterprise managed environment, so that all computers within it behave consistently in that regard. Configuring this setting to Disabled ensures that the decision remains centrally managed.
  "
  impact 1.0
  tag cce: 'CCE-36940-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Spynet') do
    it { should have_property 'LocalSettingOverrideSpynetReporting' }
    its('LocalSettingOverrideSpynetReporting') { should cmp == 0 }
  end
end

control '18.9.76.7.1_L1_Ensure_Turn_on_behavior_monitoring_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn on behavior monitoring' is set to 'Enabled'"
  desc  "
    This policy setting allows you to configure behavior monitoring for Windows Defender Antivirus.

    The recommended state for this setting is: Enabled.

    Rationale: When running an antivirus solution such as Windows Defender Antivirus, it is important to ensure that it is configured to heuristically monitor in real-time for suspicious and known malicious activity.
  "
  impact 1.0
  tag cce: 'CCE-38389-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Real-Time Protection') do
    it { should have_property 'DisableBehaviorMonitoring' }
    its('DisableBehaviorMonitoring') { should cmp == 0 }
  end
end

control '18.9.76.10.1_L1_Ensure_Scan_removable_drives_is_set_to_Enabled' do
  title "(L1) Ensure 'Scan removable drives' is set to 'Enabled'"
  desc  "
    This policy setting allows you to manage whether or not to scan for malicious software and unwanted software in the contents of removable drives, such as USB flash drives, when running a full scan.

    The recommended state for this setting is: Enabled.

    Rationale: It is important to ensure that any present removable drives are always included in any type of scan, as removable drives are more likely to contain malicious software brought in to the enterprise managed environment from an external, unmanaged computer.
  "
  impact 1.0
  tag cce: 'CCE-38409-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Scan') do
    it { should have_property 'DisableRemovableDriveScanning' }
    its('DisableRemovableDriveScanning') { should cmp == 0 }
  end
end

control '18.9.76.10.2_L1_Ensure_Turn_on_e-mail_scanning_is_set_to_Enabled' do
  title "(L1) Ensure 'Turn on e-mail scanning' is set to 'Enabled'"
  desc  "
    This policy setting allows you to configure e-mail scanning. When e-mail scanning is enabled, the engine will parse the mailbox and mail files, according to their specific format, in order to analyze the mail bodies and attachments. Several e-mail formats are currently supported, for example: pst (Outlook), dbx, mbx, mime (Outlook Express), binhex (Mac).

    The recommended state for this setting is: Enabled.

    Rationale: Incoming e-mails should be scanned by an antivirus solution such as Windows Defender Antivirus, as email attachments are a commonly used attack vector to infiltrate computers with malicious software.
  "
  impact 1.0
  tag cce: 'CCE-36958-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Scan') do
    it { should have_property 'DisableEmailScanning' }
    its('DisableEmailScanning') { should cmp == 0 }
  end
end

control '18.9.76.13.1.1_L1_Ensure_Configure_Attack_Surface_Reduction_rules_is_set_to_Enabled' do
  title "(L1) Ensure 'Configure Attack Surface Reduction rules' is set to 'Enabled'"
  desc  "
    This policy setting controls the state for the Attack Surface Reduction (ASR) rules.

    The recommended state for this setting is: Enabled.

    Rationale: Attack surface reduction helps prevent actions and apps that are typically used by exploit-seeking malware to infect machines.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR') do
    it { should have_property 'ExploitGuard_ASR_Rules' }
    its('ExploitGuard_ASR_Rules') { should cmp == 1 }
  end
end

control '18.9.76.13.1.2_L1_Ensure_Configure_Attack_Surface_Reduction_rules_Set_the_state_for_each_ASR_rule_is_configured' do
  title "(L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is 'configured'"
  desc  "
    This policy setting sets the Attack Surface Reduction rules.

    The recommended state for this setting is:

    75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84 - 1 (Block Office applications from injecting code into other processes)

    3b576869-a4ec-4529-8536-b80a7769e899 - 1 (Block Office applications from creating executable content)

    d4f940ab-401b-4efc-aadc-ad5f3c50688a - 1 (Block Office applications from creating child processes)

    92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b - 1 (Block Win32 API calls from Office macro)

    5beb7efe-fd9a-4556-801d-275e5ffc04cc - 1 (Block execution of potentially obfuscated scripts)

    d3e037e1-3eb8-44c8-a917-57927947596d - 1 (Block JavaScript or VBScript from launching downloaded executable content)

    be9ba2d9-53ea-4cdc-84e5-9b1eeee46550 - 1 (Block executable content from email client and webmail)

    **Note:** More information on ASR rules can be found at the following link: [Use Attack surface reduction rules to prevent malware infection | Microsoft Docs](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-exploit-guard/attack-surface-reduction-exploit-guard)

    Rationale: Attack surface reduction helps prevent actions and apps that are typically used by exploit-seeking malware to infect machines.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR\\Rules') do
    it { should have_property '75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84' }
    its('75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR\\Rules') do
    it { should have_property '3b576869-a4ec-4529-8536-b80a7769e899' }
    its('3b576869-a4ec-4529-8536-b80a7769e899') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR\\Rules') do
    it { should have_property 'd4f940ab-401b-4efc-aadc-ad5f3c50688a' }
    its('d4f940ab-401b-4efc-aadc-ad5f3c50688a') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR\\Rules') do
    it { should have_property '92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b' }
    its('92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR\\Rules') do
    it { should have_property '5beb7efe-fd9a-4556-801d-275e5ffc04cc' }
    its('5beb7efe-fd9a-4556-801d-275e5ffc04cc') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR\\Rules') do
    it { should have_property 'd3e037e1-3eb8-44c8-a917-57927947596d' }
    its('d3e037e1-3eb8-44c8-a917-57927947596d') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\ASR\\Rules') do
    it { should have_property 'be9ba2d9-53ea-4cdc-84e5-9b1eeee46550' }
    its('be9ba2d9-53ea-4cdc-84e5-9b1eeee46550') { should cmp == 1 }
  end
end

control '18.9.76.13.3.1_L1_Ensure_Prevent_users_and_apps_from_accessing_dangerous_websites_is_set_to_Enabled_Block' do
  title "(L1) Ensure 'Prevent users and apps from accessing dangerous websites' is set to 'Enabled: Block'"
  desc  "
    This policy setting controls Windows Defender Exploit Guard network protection.

    The recommended state for this setting is: Enabled: Block.

    Rationale: This setting can help prevent employees from using any application to access dangerous domains that may host phishing scams, exploit-hosting sites, and other malicious content on the Internet.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\Network Protection') do
    it { should have_property 'EnableNetworkProtection' }
    its('EnableNetworkProtection') { should cmp == 1 }
  end
end

control '18.9.76.14_L1_Ensure_Turn_off_Windows_Defender_AntiVirus_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn off Windows Defender AntiVirus' is set to 'Disabled'"
  desc  "
    This policy setting turns off Windows Defender Antivirus. If the setting is configured to Disabled, Windows Defender Antivirus runs and computers are scanned for malware and other potentially unwanted software.

    The recommended state for this setting is: Disabled.

    Rationale: It is important to ensure a current, updated antivirus product is scanning each computer for malicious file activity. Microsoft provides a competent solution out of the box in Windows Defender Antivirus.

    Organizations that choose to purchase a reputable 3rd-party antivirus solution may choose to exempt themselves from this recommendation in lieu of the commercial alternative.
  "
  impact 1.0
  tag cce: 'CCE-36082-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender') do
    it { should have_property 'DisableAntiSpyware' }
    its('DisableAntiSpyware') { should cmp == 0 }
  end
end

control '18.9.79.1.1_L1_Ensure_Prevent_users_from_modifying_settings_is_set_to_Enabled' do
  title "(L1) Ensure 'Prevent users from modifying settings' is set to 'Enabled'"
  desc  "
    This policy setting prevent users from making changes to the Exploit protection settings area in the Windows Defender Security Center.

    The recommended state for this setting is: Enabled.

    Rationale: Only authorized IT staff should be able to make changes to the exploit protection settings in order to ensure the organizations specific configuration is not modified.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender Security Center\\App and Browser protection') do
    it { should have_property 'DisallowExploitProtectionOverride' }
    its('DisallowExploitProtectionOverride') { should cmp == 1 }
  end
end

control '18.9.80.1.1_L1_Ensure_Configure_Windows_Defender_SmartScreen_is_set_to_Enabled_Warn_and_prevent_bypass' do
  title "(L1) Ensure 'Configure Windows Defender SmartScreen' is set to 'Enabled: Warn and prevent bypass'"
  desc  "
    This policy setting allows you to manage the behavior of Windows SmartScreen. Windows SmartScreen helps keep PCs safer by warning users before running unrecognized programs downloaded from the Internet. Some information is sent to Microsoft about files and programs run on PCs with this feature enabled.

    The recommended state for this setting is: Enabled: Warn and prevent bypass.

    Rationale: Windows SmartScreen helps keep PCs safer by warning users before running unrecognized programs downloaded from the Internet. However, due to the fact that some information is sent to Microsoft about files and programs run on PCs some organizations may prefer to disable it.
  "
  impact 1.0
  tag cce: 'CCE-35859-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'ShellSmartScreenLevel' }
    its('ShellSmartScreenLevel') { should eq 'Block' }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\System') do
    it { should have_property 'EnableSmartScreen' }
    its('EnableSmartScreen') { should cmp == 1 }
  end
end

control '18.9.84.2_L1_Ensure_Allow_Windows_Ink_Workspace_is_set_to_Enabled_On_but_disallow_access_above_lock_OR_Disabled_but_not_Enabled_On' do
  title "(L1) Ensure 'Allow Windows Ink Workspace' is set to 'Enabled: On, but disallow access above lock' OR 'Disabled' but not 'Enabled: On'"
  desc  "
    This policy setting determines whether Windows Ink items are allowed above the lock screen.

    The recommended state for this setting is: Enabled: On, but disallow access above lock OR Disabled.

    Rationale: Allowing any apps to be accessed while system is locked is not recommended. If this feature is permitted, it should only be accessible once a user authenticates with the proper credentials.
  "
  impact 1.0
  describe.one do
    describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsInkWorkspace') do
      it { should have_property 'AllowWindowsInkWorkspace' }
      its('AllowWindowsInkWorkspace') { should cmp == 1 }
    end
    describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsInkWorkspace') do
      it { should have_property 'AllowWindowsInkWorkspace' }
      its('AllowWindowsInkWorkspace') { should cmp == 0 }
    end
  end
end

control '18.9.85.1_L1_Ensure_Allow_user_control_over_installs_is_set_to_Disabled' do
  title "(L1) Ensure 'Allow user control over installs' is set to 'Disabled'"
  desc  "
    This setting controls whether users are permitted to change installation options that typically are available only to system administrators. The security features of Windows Installer normally prevent users from changing installation options that are typically reserved for system administrators, such as specifying the directory to which files are installed. If Windows Installer detects that an installation package has permitted the user to change a protected option, it stops the installation and displays a message. These security features operate only when the installation program is running in a privileged security context in which it has access to directories denied to the user.

    The recommended state for this setting is: Disabled.

    Rationale: In an enterprise managed environment, only IT staff with administrative rights should be installing or changing software on a system. Allowing users the ability to have any control over installs can risk unapproved software from being installed or removed from a system, which could cause the system to become vulnerable to compromise.
  "
  impact 1.0
  tag cce: 'CCE-36400-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\Installer') do
    it { should have_property 'EnableUserControl' }
    its('EnableUserControl') { should cmp == 0 }
  end
end

control '18.9.85.2_L1_Ensure_Always_install_with_elevated_privileges_is_set_to_Disabled' do
  title "(L1) Ensure 'Always install with elevated privileges' is set to 'Disabled'"
  desc  "
    This setting controls whether or not Windows Installer should use system permissions when it installs any program on the system.

    **Note:** This setting appears both in the Computer Configuration and User Configuration folders. To make this setting effective, you must enable the setting in both folders.

    **Caution:** If enabled, skilled users can take advantage of the permissions this setting grants to change their privileges and gain permanent access to restricted files and folders. Note that the User Configuration version of this setting is not guaranteed to be secure.

    The recommended state for this setting is: Disabled.

    Rationale: Users with limited privileges can exploit this feature by creating a Windows Installer installation package that creates a new local account that belongs to the local built-in Administrators group, adds their current account to the local built-in Administrators group, installs malicious software, or performs other unauthorized activities.
  "
  impact 1.0
  tag cce: 'CCE-36919-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer') do
    it { should have_property 'AlwaysInstallElevated' }
    its('AlwaysInstallElevated') { should cmp == 0 }
  end
end

control '18.9.86.1_L1_Ensure_Sign-in_last_interactive_user_automatically_after_a_system-initiated_restart_is_set_to_Disabled' do
  title "(L1) Ensure 'Sign-in last interactive user automatically after a system-initiated restart' is set to 'Disabled'"
  desc  "
    This policy setting controls whether a device will automatically sign-in the last interactive user after Windows Update restarts the system.

    The recommended state for this setting is: Disabled.

    Rationale: Disabling this feature will prevent the caching of user's credentials and unauthorized use of the device, and also ensure the user is aware of the restart.
  "
  impact 1.0
  tag cce: 'CCE-36977-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\policies\\system') do
    it { should have_property 'DisableAutomaticRestartSignOn' }
    its('DisableAutomaticRestartSignOn') { should cmp == 1 }
  end
end

control '18.9.95.1_L1_Ensure_Turn_on_PowerShell_Script_Block_Logging_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn on PowerShell Script Block Logging' is set to 'Disabled'"
  desc  "
    This policy setting enables logging of all PowerShell script input to the Microsoft-Windows-PowerShell/Operational event log.

    The recommended state for this setting is: Disabled.

    **Note:** In Microsoft's own hardening guidance, they recommend the opposite value, Enabled, because having this data logged improves investigations of PowerShell attack incidents. However, the default ACL on the PowerShell Operational log allows Interactive User (i.e. **any** logged on user) to read it, and therefore possibly expose passwords or other sensitive information to unauthorized users. If Microsoft locks down the default ACL on that log in the future (e.g. to restrict it only to Administrators), then we will revisit this recommendation in a future release.

    Rationale: There are potential risks of capturing passwords in the PowerShell logs. This setting should only be needed for debugging purposes, and not in normal operation, it is important to ensure this is set to Disabled.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\PowerShell\\ScriptBlockLogging') do
    it { should have_property 'EnableScriptBlockLogging' }
    its('EnableScriptBlockLogging') { should cmp == 0 }
  end
end

control '18.9.95.2_L1_Ensure_Turn_on_PowerShell_Transcription_is_set_to_Disabled' do
  title "(L1) Ensure 'Turn on PowerShell Transcription' is set to 'Disabled'"
  desc  "
    This Policy setting lets you capture the input and output of Windows PowerShell commands into text-based transcripts.

    The recommended state for this setting is: Disabled.

    Rationale: If this setting is enabled there is a risk that passwords could get stored in plain text in the PowerShell_transcript output file.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\PowerShell\\Transcription') do
    it { should have_property 'EnableTranscripting' }
    its('EnableTranscripting') { should cmp == 0 }
  end
end

control '18.9.97.1.1_L1_Ensure_Allow_Basic_authentication_is_set_to_Disabled' do
  title "(L1) Ensure 'Allow Basic authentication' is set to 'Disabled'"
  desc  "
    This policy setting allows you to manage whether the Windows Remote Management (WinRM) client uses Basic authentication.

    The recommended state for this setting is: Disabled.

    Rationale: Basic authentication is less robust than other authentication methods available in WinRM because credentials including passwords are transmitted in plain text. An attacker who is able to capture packets on the network where WinRM is running may be able to determine the credentials used for accessing remote hosts via WinRM.
  "
  impact 1.0
  tag cce: 'CCE-36310-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Client') do
    it { should have_property 'AllowBasic' }
    its('AllowBasic') { should cmp == 0 }
  end
end

control '18.9.97.1.2_L1_Ensure_Allow_unencrypted_traffic_is_set_to_Disabled' do
  title "(L1) Ensure 'Allow unencrypted traffic' is set to 'Disabled'"
  desc  "
    This policy setting allows you to manage whether the Windows Remote Management (WinRM) client sends and receives unencrypted messages over the network.

    The recommended state for this setting is: Disabled.

    Rationale: Encrypting WinRM network traffic reduces the risk of an attacker viewing or modifying WinRM messages as they transit the network.
  "
  impact 1.0
  tag cce: 'CCE-37726-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Client') do
    it { should have_property 'AllowUnencryptedTraffic' }
    its('AllowUnencryptedTraffic') { should cmp == 0 }
  end
end

control '18.9.97.1.3_L1_Ensure_Disallow_Digest_authentication_is_set_to_Enabled' do
  title "(L1) Ensure 'Disallow Digest authentication' is set to 'Enabled'"
  desc  "
    This policy setting allows you to manage whether the Windows Remote Management (WinRM) client will not use Digest authentication.

    The recommended state for this setting is: Enabled.

    Rationale: Digest authentication is less robust than other authentication methods available in WinRM, an attacker who is able to capture packets on the network where WinRM is running may be able to determine the credentials used for accessing remote hosts via WinRM.
  "
  impact 1.0
  tag cce: 'CCE-38318-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Client') do
    it { should have_property 'AllowDigest' }
    its('AllowDigest') { should cmp == 0 }
  end
end

control '18.9.97.2.1_L1_Ensure_Allow_Basic_authentication_is_set_to_Disabled' do
  title "(L1) Ensure 'Allow Basic authentication' is set to 'Disabled'"
  desc  "
    This policy setting allows you to manage whether the Windows Remote Management (WinRM) service accepts Basic authentication from a remote client.

    The recommended state for this setting is: Disabled.

    Rationale: Basic authentication is less robust than other authentication methods available in WinRM because credentials including passwords are transmitted in plain text. An attacker who is able to capture packets on the network where WinRM is running may be able to determine the credentials used for accessing remote hosts via WinRM.
  "
  impact 1.0
  tag cce: 'CCE-36254-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service') do
    it { should have_property 'AllowBasic' }
    its('AllowBasic') { should cmp == 0 }
  end
end

control '18.9.97.2.3_L1_Ensure_Allow_unencrypted_traffic_is_set_to_Disabled' do
  title "(L1) Ensure 'Allow unencrypted traffic' is set to 'Disabled'"
  desc  "
    This policy setting allows you to manage whether the Windows Remote Management (WinRM) service sends and receives unencrypted messages over the network.

    The recommended state for this setting is: Disabled.

    Rationale: Encrypting WinRM network traffic reduces the risk of an attacker viewing or modifying WinRM messages as they transit the network.
  "
  impact 1.0
  tag cce: 'CCE-38223-4'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service') do
    it { should have_property 'AllowUnencryptedTraffic' }
    its('AllowUnencryptedTraffic') { should cmp == 0 }
  end
end

control '18.9.97.2.4_L1_Ensure_Disallow_WinRM_from_storing_RunAs_credentials_is_set_to_Enabled' do
  title "(L1) Ensure 'Disallow WinRM from storing RunAs credentials' is set to 'Enabled'"
  desc  "
    This policy setting allows you to manage whether the Windows Remote Management (WinRM) service will allow RunAs credentials to be stored for any plug-ins.

    The recommended state for this setting is: Enabled.

    **Note:** If you enable and then disable this policy setting, any values that were previously configured for RunAsPassword will need to be reset.

    Rationale: Although the ability to store RunAs credentials is a convenient feature it increases the risk of account compromise slightly. For example, if you forget to lock your desktop before leaving it unattended for a few minutes another person could access not only the desktop of your computer but also any hosts you manage via WinRM with cached RunAs credentials.
  "
  impact 1.0
  tag cce: 'CCE-36000-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service') do
    it { should have_property 'DisableRunAs' }
    its('DisableRunAs') { should cmp == 1 }
  end
end

control '18.9.101.1.1_L1_Ensure_Manage_preview_builds_is_set_to_Enabled_Disable_preview_builds' do
  title "(L1) Ensure 'Manage preview builds' is set to 'Enabled: Disable preview builds'"
  desc  "
    This policy setting determines whether users can access the Windows Insider Program controls in Settings -&gt; Update and Security. These controls enable users to make their devices available for downloading and installing preview (beta) builds of Windows software.

    The recommended state for this setting is: Enabled: Disable preview builds.

    Rationale: It can be risky for experimental features to be allowed in an enterprise managed environment because this can introduce bugs and security holes into systems, making it easier for an attacker to gain access. It is generally preferred to only use production-ready builds.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate') do
    it { should have_property 'ManagePreviewBuilds' }
    its('ManagePreviewBuilds') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate') do
    it { should have_property 'ManagePreviewBuildsPolicyValue' }
    its('ManagePreviewBuildsPolicyValue') { should cmp == 0 }
  end
end

control '18.9.101.1.2_L1_Ensure_Select_when_Preview_Builds_and_Feature_Updates_are_received_is_set_to_Enabled_Semi-Annual_Channel_180_or_more_days' do
  title "(L1) Ensure 'Select when Preview Builds and Feature Updates are received' is set to 'Enabled: Semi-Annual Channel, 180 or more days'"
  desc  "
    This policy setting determines the level of Preview Build or Feature Updates to receive, and when.

    The Windows readiness level for each new Windows 10 Feature Update is classified in one of 5 categories, depending on your organizations level of comfort with receiving them:

    * **Preview Build - Fast:** Devices set to this level will be the first to receive new builds of Windows with features not yet available to the general public. Select Fast to participate in identifying and reporting issues to Microsoft, and provide suggestions on new functionality.

    * **Preview Build - Slow:** Devices set to this level receive new builds of Windows before they are available to the general public, but at a slower cadence than those set to Fast, and with changes and fixes identified in earlier builds.

    * **Release Preview:** Receive builds of Windows just before Microsoft releases them to the general public.

    * **Semi-Annual Channel (Targeted):** Receive feature updates when they are released to the general public.

    * **Semi-Annual Channel:** Feature updates will arrive when they are declared Semi-Annual Channel. This usually occurs about 4 months after Semi-Annual Channel (Targeted), indicating that Microsoft, Independent Software Vendors (ISVs), partners and customer believe that the release is ready for broad deployment.

    The recommended state for this setting is: Enabled: Semi-Annual Channel, 180 or more days.

    **Note:** If the \"Allow Telemetry\" policy is set to 0, this policy will have no effect.

    **Note #2:** Starting with Windows Server 2016 RTM (Release 1607), Microsoft introduced a new Windows Update (WU) client behavior called **Dual Scan**, with an eye to cloud-based update management. In some cases, this Dual Scan feature can interfere with Windows Updates from Windows Server Update Services (WSUS) and/or manual WU updates. If you are using WSUS in your environment, you may need to set the above setting to Not Configured**or** configure the setting **Do not allow update deferral policies to cause scans against Windows Update** (added in the Windows 10 Release 1709 Administrative Templates) in order to prevent the Dual Scan feature from interfering. More information on Dual Scan is available at these links:

    * [Demystifying &#x201C;Dual Scan&#x201D; &#x2013; WSUS Product Team Blog](https://blogs.technet.microsoft.com/wsus/2017/05/05/demystifying-dual-scan/)
    * [Improving Dual Scan on 1607 &#x2013; WSUS Product Team Blog](https://blogs.technet.microsoft.com/wsus/2017/08/04/improving-dual-scan-on-1607/)
    **Note #3:** Prior to Windows Server 2016 R1709, values above 180 days are not recognized by the OS. Starting with Windows Server 2016 R1709, the maximum number of days you can defer is 365 days.

    Rationale: Forcing new features without prior testing in your environment could cause software incompatibilities as well as introducing new bugs into the operating system. In an enterprise managed environment, it is generally preferred to delay Feature Updates until thorough testing and a deployment plan is in place. This recommendation delays the **automatic** installation of new features as long as possible.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate') do
    it { should have_property 'DeferFeatureUpdates' }
    its('DeferFeatureUpdates') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate') do
    it { should have_property 'BranchReadinessLevel' }
    its('BranchReadinessLevel') { should cmp == 32 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate') do
    it { should have_property 'DeferFeatureUpdatesPeriodInDays' }
    its('DeferFeatureUpdatesPeriodInDays') { should cmp >= 180 }
  end
end

control '18.9.101.1.3_L1_Ensure_Select_when_Quality_Updates_are_received_is_set_to_Enabled_0_days' do
  title "(L1) Ensure 'Select when Quality Updates are received' is set to 'Enabled: 0 days'"
  desc  "
    This settings controls when Quality Updates are received.

    The recommended state for this setting is: Enabled: 0 days.

    **Note:** If the \"Allow Telemetry\" policy is set to 0, this policy will have no effect.

    **Note #2:** Starting with Windows Server 2016 RTM (Release 1607), Microsoft introduced a new Windows Update (WU) client behavior called **Dual Scan**, with an eye to cloud-based update management. In some cases, this Dual Scan feature can interfere with Windows Updates from Windows Server Update Services (WSUS) and/or manual WU updates. If you are using WSUS in your environment, you may need to set the above setting to Not Configured**or** configure the setting **Do not allow update deferral policies to cause scans against Windows Update** (added in the Windows 10 Release 1709 Administrative Templates) in order to prevent the Dual Scan feature from interfering. More information on Dual Scan is available at these links:

    * [Demystifying &#x201C;Dual Scan&#x201D; &#x2013; WSUS Product Team Blog](https://blogs.technet.microsoft.com/wsus/2017/05/05/demystifying-dual-scan/)
    * [Improving Dual Scan on 1607 &#x2013; WSUS Product Team Blog](https://blogs.technet.microsoft.com/wsus/2017/08/04/improving-dual-scan-on-1607/)

    Rationale: Quality Updates can contain important bug fixes and/or security patches, and should be installed as soon as possible.
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate') do
    it { should have_property 'DeferQualityUpdates' }
    its('DeferQualityUpdates') { should cmp == 1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate') do
    it { should have_property 'DeferQualityUpdatesPeriodInDays' }
    its('DeferQualityUpdatesPeriodInDays') { should cmp == 0 }
  end
end

control '18.9.101.2_L1_Ensure_Configure_Automatic_Updates_is_set_to_Enabled' do
  title "(L1) Ensure 'Configure Automatic Updates' is set to 'Enabled'"
  desc  "
    This policy setting specifies whether computers in your environment will receive security updates from Windows Update or WSUS. If you configure this policy setting to Enabled, the operating system will recognize when a network connection is available and then use the network connection to search Windows Update or your designated intranet site for updates that apply to them.

    After you configure this policy setting to Enabled, select one of the following three options in the Configure Automatic Updates Properties dialog box to specify how the service will work:

    * 2 - Notify for download and auto install **(Notify before downloading any updates)**
    * 3 - Auto download and notify for install **(Download the updates automatically and notify when they are ready to be installed.) (Default setting)**
    * 4 - Auto download and schedule the install **(Automatically download updates and install them on the schedule specified below.))**
    * 5 - Allow local admin to choose setting **(Leave decision on above choices up to the local Administrators (Not Recommended))**
    The recommended state for this setting is: Enabled.

    **Note:** The sub-setting \"**Configure automatic updating:**\" has 4 possible values &#x2013; all of them are valid depending on specific organizational needs, however if feasible we suggest using a value of 4 - Auto download and schedule the install. This suggestion is not a scored requirement.

    **Note #2:** Organizations that utilize a 3rd-party solution for patching may choose to exempt themselves from this setting, and instead configure it to Disabled so that the native Windows Update mechanism does not interfere with the 3rd-party patching process.

    Rationale: Although each version of Windows is thoroughly tested before release, it is possible that problems will be discovered after the products are shipped. The Configure Automatic Updates setting can help you ensure that the computers in your environment will always have the most recent critical operating system updates and service packs installed.
  "
  impact 1.0
  tag cce: 'CCE-36172-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU') do
    it { should have_property 'NoAutoUpdate' }
    its('NoAutoUpdate') { should cmp == 0 }
  end
end

control '18.9.101.3_L1_Ensure_Configure_Automatic_Updates_Scheduled_install_day_is_set_to_0_-_Every_day' do
  title "(L1) Ensure 'Configure Automatic Updates: Scheduled install day' is set to '0 - Every day'"
  desc  "
    This policy setting specifies when computers in your environment will receive security updates from Windows Update or WSUS.

    The recommended state for this setting is: 0 - Every day.

    **Note:** This setting is only applicable if 4 - Auto download and schedule the install is selected in Rule 18.9.101.2. It will have no impact if any other option is selected.

    Rationale: Although each version of Windows is thoroughly tested before release, it is possible that problems will be discovered after the products are shipped. The Configure Automatic Updates setting can help you ensure that the computers in your environment will always have the most recent critical operating system updates and service packs installed.
  "
  impact 1.0
  tag cce: 'CCE-36172-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU') do
    it { should have_property 'ScheduledInstallDay' }
    its('ScheduledInstallDay') { should cmp == 0 }
  end
end

control '18.9.101.4_L1_Ensure_No_auto-restart_with_logged_on_users_for_scheduled_automatic_updates_installations_is_set_to_Disabled' do
  title "(L1) Ensure 'No auto-restart with logged on users for scheduled automatic updates installations' is set to 'Disabled'"
  desc  "
    This policy setting specifies that Automatic Updates will wait for computers to be restarted by the users who are logged on to them to complete a scheduled installation.

    The recommended state for this setting is: Disabled.

    **Note:** This setting applies only when you configure Automatic Updates to perform scheduled update installations. If you configure the Configure Automatic Updates setting to Disabled, this setting has no effect.

    Rationale: Some security updates require that the computer be restarted to complete an installation. If the computer cannot restart automatically, then the most recent update will not completely install and no new updates will download to the computer until it is restarted. Without the auto-restart functionality, users who are not security-conscious may choose to indefinitely delay the restart, therefore keeping the computer in a less secure state.
  "
  impact 1.0
  tag cce: 'CCE-37027-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU') do
    it { should have_property 'NoAutoRebootWithLoggedOnUsers' }
    its('NoAutoRebootWithLoggedOnUsers') { should cmp == 0 }
  end
end
