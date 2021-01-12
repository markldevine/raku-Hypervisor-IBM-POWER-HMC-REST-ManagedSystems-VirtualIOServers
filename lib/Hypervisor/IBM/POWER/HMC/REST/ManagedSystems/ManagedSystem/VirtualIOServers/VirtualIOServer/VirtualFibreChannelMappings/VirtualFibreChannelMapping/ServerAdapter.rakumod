need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings::VirtualFibreChannelMapping::ServerAdapter::PhysicalPort;
use     URI;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings::VirtualFibreChannelMapping::ServerAdapter:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                                                                                                                                                                        $names-checked = False;
my      Bool                                                                                                                                                                                        $analyzed = False;
my      Lock                                                                                                                                                                                        $lock = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config                                                                                                                                                   $.config is required;
has     Bool                                                                                                                                                                                        $.initialized = False;
has     Str                                                                                                                                                                                         $.AdapterType                           is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.DynamicReconfigurationConnectorName   is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.LocationCode                          is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.LocalPartitionID                      is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.RequiredAdapter                       is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.VariedOn                              is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.VirtualSlotNumber                     is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.AdapterName                           is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.ConnectingPartitionID                 is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.ConnectingVirtualSlotNumber           is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.UniqueDeviceID                        is conditional-initialization-attribute;
has     Str                                                                                                                                                                                         $.MapPort                               is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings::VirtualFibreChannelMapping::ServerAdapter::PhysicalPort   $.PhysicalPort                          is conditional-initialization-attribute;

method  xml-name-exceptions () { return set <Metadata>; }

submethod TWEAK {
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_SUBMETHOD>;
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
    return self                             if $!initialized;
    self.config.diag.post:                  self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!AdapterType                           = self.etl-text(:TAG<AdapterType>,                          :$!xml)             if self.attribute-is-accessed(self.^name, 'AdapterType');
    $!DynamicReconfigurationConnectorName   = self.etl-text(:TAG<DynamicReconfigurationConnectorName>,  :$!xml)             if self.attribute-is-accessed(self.^name, 'DynamicReconfigurationConnectorName');
    $!LocationCode                          = self.etl-text(:TAG<LocationCode>,                         :$!xml)             if self.attribute-is-accessed(self.^name, 'LocationCode');
    $!LocalPartitionID                      = self.etl-text(:TAG<LocalPartitionID>,                     :$!xml)             if self.attribute-is-accessed(self.^name, 'LocalPartitionID');
    $!RequiredAdapter                       = self.etl-text(:TAG<RequiredAdapter>,                      :$!xml)             if self.attribute-is-accessed(self.^name, 'RequiredAdapter');
    $!VariedOn                              = self.etl-text(:TAG<VariedOn>,                             :$!xml)             if self.attribute-is-accessed(self.^name, 'VariedOn');
    $!VirtualSlotNumber                     = self.etl-text(:TAG<VirtualSlotNumber>,                    :$!xml)             if self.attribute-is-accessed(self.^name, 'VirtualSlotNumber');
    $!AdapterName                           = self.etl-text(:TAG<AdapterName>,                          :$!xml)             if self.attribute-is-accessed(self.^name, 'AdapterName');
    $!ConnectingPartitionID                 = self.etl-text(:TAG<ConnectingPartitionID>,                :$!xml)             if self.attribute-is-accessed(self.^name, 'ConnectingPartitionID');
    $!ConnectingVirtualSlotNumber           = self.etl-text(:TAG<ConnectingVirtualSlotNumber>,          :$!xml)             if self.attribute-is-accessed(self.^name, 'ConnectingVirtualSlotNumber');
    $!UniqueDeviceID                        = self.etl-text(:TAG<UniqueDeviceID>,                       :$!xml)             if self.attribute-is-accessed(self.^name, 'UniqueDeviceID');
    $!MapPort                               = self.etl-text(:TAG<MapPort>,                              :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'MapPort');
    if self.attribute-is-accessed(self.^name, 'PhysicalPort') {
        $!PhysicalPort          = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings::VirtualFibreChannelMapping::ServerAdapter::PhysicalPort.new(:$!config, :xml(self.etl-branch(:TAG<PhysicalPort>, :$!xml, :optional)));
    }
    $!xml                                   = Nil;
    $!initialized                           = True;
    self;
}

=finish
