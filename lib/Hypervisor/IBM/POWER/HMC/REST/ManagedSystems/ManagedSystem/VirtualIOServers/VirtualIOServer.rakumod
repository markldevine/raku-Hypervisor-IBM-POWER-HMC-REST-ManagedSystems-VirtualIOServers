need    Hypervisor::IBM::POWER::HMC::REST::Atom;
need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionCapabilities;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionMemoryConfiguration;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::HostEthernetAdapterLogicalPorts;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::HardwareAcceleratorQoS;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PhysicalVolumes;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::TrunkAdapters;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualSCSIMappings;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::FreeIOAdaptersForLinkAggregation;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::FreeEthenetBackingDevicesForSEA;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualNICBackingDevices;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualIOServerCapabilities;
use     URI;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                                                                                                                    $names-checked  = False;
my      Bool                                                                                                                                    $analyzed       = False;
my      Lock                                                                                                                                    $lock           = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config                                                                                               $.config        is required;
has     Bool                                                                                                                                    $.initialized   = False;
has     Hypervisor::IBM::POWER::HMC::REST::Atom                                                                                                 $.atom                                  is conditional-initialization-attribute;
has     Str                                                                                                                                     $.id;
has     DateTime                                                                                                                                $.published                             is conditional-initialization-attribute;
has     Str                                                                                                                                     $.AllowPerformanceDataCollection        is conditional-initialization-attribute;
has     URI                                                                                                                                     $.AssociatedPartitionProfile            is conditional-initialization-attribute;
has     Str                                                                                                                                     $.AvailabilityPriority                  is conditional-initialization-attribute;
has     Str                                                                                                                                     $.CurrentProcessorCompatibilityMode     is conditional-initialization-attribute;
has     Str                                                                                                                                     $.CurrentProfileSync                    is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsBootable                            is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsConnectionMonitoringEnabled         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsOperationInProgress                 is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsRedundantErrorPathReportingEnabled  is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsTimeReferencePartition              is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsVirtualServiceAttentionLEDOn        is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsVirtualTrustedPlatformModuleEnabled is conditional-initialization-attribute;
has     Str                                                                                                                                     $.KeylockPosition                       is conditional-initialization-attribute;
has     Str                                                                                                                                     $.LogicalSerialNumber                   is conditional-initialization-attribute;
has     Str                                                                                                                                     $.OperatingSystemVersion                is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionCapabilities              $.PartitionCapabilities                 is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PartitionID                           is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration           $.PartitionIOConfiguration              is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionMemoryConfiguration       $.PartitionMemoryConfiguration          is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PartitionName;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration    $.PartitionProcessorConfiguration       is conditional-initialization-attribute;
has     URI                                                                                                                                     @.PartitionProfiles                     is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PartitionState                        is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PartitionType                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PartitionUUID                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PendingProcessorCompatibilityMode     is conditional-initialization-attribute;
has     URI                                                                                                                                     $.ProcessorPool                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.ProgressPartitionDataRemaining        is conditional-initialization-attribute;
has     Str                                                                                                                                     $.ProgressPartitionDataTotal            is conditional-initialization-attribute;
has     Str                                                                                                                                     $.ProgressState                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.ResourceMonitoringControlState        is conditional-initialization-attribute;
has     Str                                                                                                                                     $.ResourceMonitoringIPAddress           is conditional-initialization-attribute;
has     URI                                                                                                                                     $.AssociatedManagedSystem               is conditional-initialization-attribute;
has     URI                                                                                                                                     @.SRIOVEthernetLogicalPorts             is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::HostEthernetAdapterLogicalPorts    $.HostEthernetAdapterLogicalPorts       is conditional-initialization-attribute;
has     Str                                                                                                                                     $.MACAddressPrefix                      is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsServicePartition                    is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PowerVMManagementCapable              is conditional-initialization-attribute;
has     Str                                                                                                                                     $.ReferenceCode                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.AssignAllResources                    is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::HardwareAcceleratorQoS             $.HardwareAcceleratorQoS                is conditional-initialization-attribute;
has     Str                                                                                                                                     $.LastActivatedProfile                  is conditional-initialization-attribute;
has     Str                                                                                                                                     $.HasPhysicalIO                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.OperatingSystemType                   is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PendingSecureBoot                     is conditional-initialization-attribute;
has     Str                                                                                                                                     $.CurrentSecureBoot                     is conditional-initialization-attribute;
has     Str                                                                                                                                     $.PowerOnWithHypervisor                 is conditional-initialization-attribute;
has     Str                                                                                                                                     $.Description                           is conditional-initialization-attribute;
has     Str                                                                                                                                     $.APICapable                            is conditional-initialization-attribute;
has     Str                                                                                                                                     $.IsVNICCapable                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.VNICFailOverCapable                   is conditional-initialization-attribute;
has     URI                                                                                                                                     @.LinkAggregations                      is conditional-initialization-attribute;
has     Str                                                                                                                                     $.ManagerPassthroughCapable             is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories                  $.MediaRepositories                     is conditional-initialization-attribute;
has     Str                                                                                                                                     $.MoverServicePartition                 is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PhysicalVolumes                    $.PhysicalVolumes                       is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters             $.SharedEthernetAdapters                is conditional-initialization-attribute;
has     URI                                                                                                                                     @.StoragePools                          is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::TrunkAdapters                      $.TrunkAdapters                         is conditional-initialization-attribute;
has     Str                                                                                                                                     $.VirtualIOServerLicenseAccepted        is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings        $.VirtualFibreChannelMappings           is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualSCSIMappings                $.VirtualSCSIMappings                   is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::FreeIOAdaptersForLinkAggregation   $.FreeIOAdaptersForLinkAggregation      is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::FreeEthenetBackingDevicesForSEA    $.FreeEthenetBackingDevicesForSEA       is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualNICBackingDevices           $.VirtualNICBackingDevices              is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualIOServerCapabilities        $.VirtualIOServerCapabilities           is conditional-initialization-attribute;

method  xml-name-exceptions () { return set <title link author etag:etag content Metadata> }

submethod TWEAK {
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_SUBMETHOD>;
    self.config.diag.post:      sprintf("%-20s %10s: %11s", self.^name.subst(/^.+'::'(.+)$/, {$0}), 'START', 't' ~ $*THREAD.id) if %*ENV<HIPH_THREAD_START>;
    my $proceed-with-name-check = False;
    my $proceed-with-analyze    = False;
    $lock.protect({
        if !$analyzed           { $proceed-with-analyze    = True; $analyzed      = True; }
        if !$names-checked      { $proceed-with-name-check = True; $names-checked = True; }
    });
    self.etl-node-name-check    if $proceed-with-name-check;
    self.init;
    self.analyze                if $proceed-with-analyze;
    self;
}

method init () {
    return self                                 if $!initialized;
    self.config.diag.post:                      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $xml-content                                = self.etl-branch(:TAG<content>,                                            :$!xml);
    $xml-VirtualIOServer                        = self.etl-branch(:TAG<VirtualIOServer:VirtualIOServer>,                    :xml($xml-content));
    $!atom                                      = self.etl-atom(:xml(self.etl-branch(:TAG<Metadata>,                        :xml($xml-VirtualIOServer))))           if self.attribute-is-accessed(self.^name, 'atom');
    $!id                                        = self.etl-text(:TAG<id>,                                                   :$!xml);
    $!published                                 = DateTime.new(self.etl-text(:TAG<published>,                               :$!xml))                                if self.attribute-is-accessed(self.^name, 'published');
    $!AllowPerformanceDataCollection            = self.etl-text(:TAG<AllowPerformanceDataCollection>,                       :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'AllowPerformanceDataCollection');
    $!AssociatedPartitionProfile                = self.etl-href(:xml(self.etl-branch(:TAG<AssociatedPartitionProfile>,      :xml($xml-VirtualIOServer))))           if self.attribute-is-accessed(self.^name, 'AssociatedPartitionProfile');
    $!AvailabilityPriority                      = self.etl-text(:TAG<AvailabilityPriority>,                                 :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'AvailabilityPriority');
    $!CurrentProcessorCompatibilityMode         = self.etl-text(:TAG<CurrentProcessorCompatibilityMode>,                    :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'CurrentProcessorCompatibilityMode');
    $!CurrentProfileSync                        = self.etl-text(:TAG<CurrentProfileSync>,                                   :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'CurrentProfileSync');
    $!IsBootable                                = self.etl-text(:TAG<IsBootable>,                                           :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsBootable');
    $!IsConnectionMonitoringEnabled             = self.etl-text(:TAG<IsConnectionMonitoringEnabled>,                        :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsConnectionMonitoringEnabled');
    $!IsOperationInProgress                     = self.etl-text(:TAG<IsOperationInProgress>,                                :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsOperationInProgress');
    $!IsRedundantErrorPathReportingEnabled      = self.etl-text(:TAG<IsRedundantErrorPathReportingEnabled>,                 :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsRedundantErrorPathReportingEnabled');
    $!IsTimeReferencePartition                  = self.etl-text(:TAG<IsTimeReferencePartition>,                             :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsTimeReferencePartition');
    $!IsVirtualServiceAttentionLEDOn            = self.etl-text(:TAG<IsVirtualServiceAttentionLEDOn>,                       :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsVirtualServiceAttentionLEDOn');
    $!IsVirtualTrustedPlatformModuleEnabled     = self.etl-text(:TAG<IsVirtualTrustedPlatformModuleEnabled>,                :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsVirtualTrustedPlatformModuleEnabled');
    $!KeylockPosition                           = self.etl-text(:TAG<KeylockPosition>,                                      :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'KeylockPosition');
    $!LogicalSerialNumber                       = self.etl-text(:TAG<LogicalSerialNumber>,                                  :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'LogicalSerialNumber');
    $!OperatingSystemVersion                    = self.etl-text(:TAG<OperatingSystemVersion>,                               :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'OperatingSystemVersion');
    if self.attribute-is-accessed(self.^name, 'PartitionCapabilities') {
        $xml-PartitionCapabilities              = self.etl-branch(:TAG<PartitionCapabilities>,                              :xml($xml-VirtualIOServer));
        $!PartitionCapabilities                 = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionCapabilities.new(:$!config, :xml($xml-PartitionCapabilities));
    }
    $!PartitionID                               = self.etl-text(:TAG<PartitionID>,                                          :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PartitionID');
    if self.attribute-is-accessed(self.^name, 'PartitionIOConfiguration') {
        $xml-PartitionIOConfiguration           = self.etl-branch(:TAG<PartitionIOConfiguration>,                           :xml($xml-VirtualIOServer));
        $!PartitionIOConfiguration              = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration.new(:$!config, :xml($xml-PartitionIOConfiguration));
    }
    if self.attribute-is-accessed(self.^name, 'PartitionMemoryConfiguration') {
        $xml-PartitionMemoryConfiguration       = self.etl-branch(:TAG<PartitionMemoryConfiguration>,                       :xml($xml-VirtualIOServer));
        $!PartitionMemoryConfiguration          = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionMemoryConfiguration.new(:$!config, :xml($xml-PartitionMemoryConfiguration));
    }
    $!PartitionName                             = self.etl-text(:TAG<PartitionName>,                                        :xml($xml-VirtualIOServer));
    if self.attribute-is-accessed(self.^name, 'PartitionProcessorConfiguration') {
        $xml-PartitionProcessorConfiguration    = self.etl-branch(:TAG<PartitionProcessorConfiguration>,                    :xml($xml-VirtualIOServer));
        $!PartitionProcessorConfiguration       = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration.new(:$!config, :xml($xml-PartitionProcessorConfiguration));
    }
    if self.attribute-is-accessed(self.^name, 'PartitionProfiles') {
        $xml-PartitionProfiles                  = self.etl-branch(:TAG<PartitionProfiles>,                                   :xml($xml-VirtualIOServer));
        @!PartitionProfiles                     = self.etl-links-URIs(:xml(self.etl-branch(:TAG<PartitionProfiles>,         :xml($xml-VirtualIOServer))));
    }
    $!PartitionState                            = self.etl-text(:TAG<PartitionState>,                                       :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PartitionState');
    $!PartitionType                             = self.etl-text(:TAG<PartitionType>,                                        :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PartitionType');
    $!PartitionUUID                             = self.etl-text(:TAG<PartitionUUID>,                                        :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PartitionUUID');
    $!PendingProcessorCompatibilityMode         = self.etl-text(:TAG<PendingProcessorCompatibilityMode>,                    :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PendingProcessorCompatibilityMode');
    $!ProcessorPool                             = self.etl-href(:xml(self.etl-branch(:TAG<ProcessorPool>,                   :xml($xml-VirtualIOServer))))           if self.attribute-is-accessed(self.^name, 'ProcessorPool');
    $!ProgressPartitionDataRemaining            = self.etl-text(:TAG<ProgressPartitionDataRemaining>,                       :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'ProgressPartitionDataRemaining');
    $!ProgressPartitionDataTotal                = self.etl-text(:TAG<ProgressPartitionDataTotal>,                           :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'ProgressPartitionDataTotal');
    $!ProgressState                             = self.etl-text(:TAG<ProgressState>,                                        :xml($xml-VirtualIOServer), :optional)  if self.attribute-is-accessed(self.^name, 'ProgressState');
    $!ResourceMonitoringControlState            = self.etl-text(:TAG<ResourceMonitoringControlState>,                       :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'ResourceMonitoringControlState');
    $!ResourceMonitoringIPAddress               = self.etl-text(:TAG<ResourceMonitoringIPAddress>,                          :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'ResourceMonitoringIPAddress');
    $!AssociatedManagedSystem                   = self.etl-href(:xml(self.etl-branch(:TAG<AssociatedManagedSystem>,         :xml($xml-VirtualIOServer))))           if self.attribute-is-accessed(self.^name, 'AssociatedManagedSystem');
    if self.attribute-is-accessed(self.^name, 'SRIOVEthernetLogicalPorts') {
        $xml-SRIOVEthernetLogicalPorts          = self.etl-branch(:TAG<SRIOVEthernetLogicalPorts>,          :xml($xml-VirtualIOServer));
        @!SRIOVEthernetLogicalPorts             = self.etl-links-URIs(:xml(self.etl-branch(:TAG<SRIOVEthernetLogicalPorts>, :xml($xml-VirtualIOServer))));
    }
    if self.attribute-is-accessed(self.^name, 'HostEthernetAdapterLogicalPorts') {
        $xml-HostEthernetAdapterLogicalPorts    = self.etl-branch(:TAG<HostEthernetAdapterLogicalPorts>,                    :xml($xml-VirtualIOServer));
        $!HostEthernetAdapterLogicalPorts       = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::HostEthernetAdapterLogicalPorts.new(:$!config, :xml($xml-HostEthernetAdapterLogicalPorts));
    }
    $!MACAddressPrefix                          = self.etl-text(:TAG<MACAddressPrefix>,                                     :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'MACAddressPrefix');
    $!IsServicePartition                        = self.etl-text(:TAG<IsServicePartition>,                                   :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsServicePartition');
    $!PowerVMManagementCapable                  = self.etl-text(:TAG<PowerVMManagementCapable>,                             :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PowerVMManagementCapable');
    $!ReferenceCode                             = self.etl-text(:TAG<ReferenceCode>,                                        :xml($xml-VirtualIOServer), :optional)  if self.attribute-is-accessed(self.^name, 'ReferenceCode');
    $!AssignAllResources                        = self.etl-text(:TAG<AssignAllResources>,                                   :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'AssignAllResources');
    if self.attribute-is-accessed(self.^name, 'HardwareAcceleratorQoS') {
        $xml-HardwareAcceleratorQoS             = self.etl-branch(:TAG<HardwareAcceleratorQoS>,                             :xml($xml-VirtualIOServer));
        $!HardwareAcceleratorQoS                = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::HardwareAcceleratorQoS.new(:$!config, :xml($xml-HardwareAcceleratorQoS));
    }
    $!LastActivatedProfile                      = self.etl-text(:TAG<LastActivatedProfile>,                                 :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'LastActivatedProfile');
    $!HasPhysicalIO                             = self.etl-text(:TAG<HasPhysicalIO>,                                        :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'HasPhysicalIO');
    $!OperatingSystemType                       = self.etl-text(:TAG<OperatingSystemType>,                                  :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'OperatingSystemType');
    $!PendingSecureBoot                         = self.etl-text(:TAG<PendingSecureBoot>,                                    :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PendingSecureBoot');
    $!CurrentSecureBoot                         = self.etl-text(:TAG<CurrentSecureBoot>,                                    :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'CurrentSecureBoot');
    $!PowerOnWithHypervisor                     = self.etl-text(:TAG<PowerOnWithHypervisor>,                                :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'PowerOnWithHypervisor');
    $!Description                               = self.etl-text(:TAG<Description>,                                          :xml($xml-VirtualIOServer), :optional)  if self.attribute-is-accessed(self.^name, 'Description');
    $!APICapable                                = self.etl-text(:TAG<APICapable>,                                           :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'APICapable');
    $!IsVNICCapable                             = self.etl-text(:TAG<IsVNICCapable>,                                        :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'IsVNICCapable');
    $!VNICFailOverCapable                       = self.etl-text(:TAG<VNICFailOverCapable>,                                  :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'VNICFailOverCapable');
    if self.attribute-is-accessed(self.^name, 'LinkAggregations') {
        $xml-LinkAggregations                   = self.etl-branch(:TAG<LinkAggregations>,                   :xml($xml-VirtualIOServer));
        @!LinkAggregations                      = self.etl-links-URIs(:xml(self.etl-branch(:TAG<LinkAggregations>,          :xml($xml-VirtualIOServer))));
    }
    $!ManagerPassthroughCapable                 = self.etl-text(:TAG<ManagerPassthroughCapable>,                            :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'ManagerPassthroughCapable');
    if self.attribute-is-accessed(self.^name, 'MediaRepositories') {
        $xml-MediaRepositories                  = self.etl-branch(:TAG<MediaRepositories>,                                  :xml($xml-VirtualIOServer));
        $!MediaRepositories                     = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories.new(:$!config, :xml($xml-MediaRepositories));
    }
    $!MoverServicePartition                     = self.etl-text(:TAG<MoverServicePartition>,                                :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'MoverServicePartition');
    if self.attribute-is-accessed(self.^name, 'PhysicalVolumes') {
        $xml-PhysicalVolumes                    = self.etl-branch(:TAG<PhysicalVolumes>,                                    :xml($xml-VirtualIOServer));
        $!PhysicalVolumes                       = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PhysicalVolumes.new(:$!config, :xml($xml-PhysicalVolumes));
    }
    if self.attribute-is-accessed(self.^name, 'SharedEthernetAdapters') {
        $xml-SharedEthernetAdapters             = self.etl-branch(:TAG<SharedEthernetAdapters>,                             :xml($xml-VirtualIOServer));
        $!SharedEthernetAdapters                = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters.new(:$!config, :xml($xml-SharedEthernetAdapters));
    }
    @!StoragePools                              = self.etl-links-URIs(:xml(self.etl-branch(:TAG<StoragePools>,              :xml($xml-VirtualIOServer))))           if self.attribute-is-accessed(self.^name, 'StoragePools');
    if self.attribute-is-accessed(self.^name, 'TrunkAdapters') {
        $xml-TrunkAdapters                      = self.etl-branch(:TAG<TrunkAdapters>,                                      :xml($xml-VirtualIOServer));
        $!TrunkAdapters                         = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::TrunkAdapters.new(:$!config, :xml($xml-TrunkAdapters));
    }
    $!VirtualIOServerLicenseAccepted            = self.etl-text(:TAG<VirtualIOServerLicenseAccepted>,                       :xml($xml-VirtualIOServer))             if self.attribute-is-accessed(self.^name, 'VirtualIOServerLicenseAccepted');
    if self.attribute-is-accessed(self.^name, 'VirtualFibreChannelMappings') {
        $xml-VirtualFibreChannelMappings        = self.etl-branch(:TAG<VirtualFibreChannelMappings>,                        :xml($xml-VirtualIOServer));
        $!VirtualFibreChannelMappings           = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings.new(:$!config, :xml($xml-VirtualFibreChannelMappings));
    }
    if self.attribute-is-accessed(self.^name, 'VirtualSCSIMappings') {
        $xml-VirtualSCSIMappings                = self.etl-branch(:TAG<VirtualSCSIMappings>,                                :xml($xml-VirtualIOServer));
        $!VirtualSCSIMappings                   = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualSCSIMappings.new(:$!config, :xml($xml-VirtualSCSIMappings));
    }
    if self.attribute-is-accessed(self.^name, 'FreeIOAdaptersForLinkAggregation') {
        $xml-FreeIOAdaptersForLinkAggregation   = self.etl-branch(:TAG<FreeIOAdaptersForLinkAggregation>,                   :xml($xml-VirtualIOServer));
        $!FreeIOAdaptersForLinkAggregation      = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::FreeIOAdaptersForLinkAggregation.new(:$!config, :xml($xml-FreeIOAdaptersForLinkAggregation));
    }
    if self.attribute-is-accessed(self.^name, 'FreeEthenetBackingDevicesForSEA') {
        $xml-FreeEthenetBackingDevicesForSEA    = self.etl-branch(:TAG<FreeEthenetBackingDevicesForSEA>,                    :xml($xml-VirtualIOServer));
        $!FreeEthenetBackingDevicesForSEA       = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::FreeEthenetBackingDevicesForSEA.new(:$!config, :xml($xml-FreeEthenetBackingDevicesForSEA));
    }
    if self.attribute-is-accessed(self.^name, 'VirtualNICBackingDevices') {
        $xml-VirtualNICBackingDevices           = self.etl-branch(:TAG<VirtualNICBackingDevices>,                           :xml($xml-VirtualIOServer));
        $!VirtualNICBackingDevices              = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualNICBackingDevices.new(:$!config, :xml($xml-VirtualNICBackingDevices));
    }
    if self.attribute-is-accessed(self.^name, 'VirtualIOServerCapabilities') {
        $xml-VirtualIOServerCapabilities        = self.etl-branch(:TAG<VirtualIOServerCapabilities>,                        :xml($xml-VirtualIOServer));
        $!VirtualIOServerCapabilities           = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualIOServerCapabilities.new(:$!config, :xml($xml-VirtualIOServerCapabilities));
    }
    $!xml                                       = Nil;
    $!initialized                               = True;
    self;
}

=finish
