need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter::PhysicalFibreChannelPorts;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                                                                                                                                                                                                                                        $names-checked                          = False;
my      Bool                                                                                                                                                                                                                                                        $analyzed                               = False;
my      Lock                                                                                                                                                                                                                                                        $lock                                   = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config                                                                                                                                                                                                                   $.config                                is required;
has     Bool                                                                                                                                                                                                                                                        $.initialized                           = False;
has     Str                                                                                                                                                                                                                                                         $.AdapterID                             is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                         $.Description                           is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                         $.DeviceName                            is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                         $.DynamicReconfigurationConnectorName   is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                         $.PhysicalLocation                      is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter::PhysicalFibreChannelPorts    $.PhysicalFibreChannelPorts             is conditional-initialization-attribute;

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
    $!AdapterID                             = self.etl-text(:TAG<AdapterID>,                            :$!xml) if self.attribute-is-accessed(self.^name, 'AdapterID');
    $!Description                           = self.etl-text(:TAG<Description>,                          :$!xml) if self.attribute-is-accessed(self.^name, 'Description');
    $!DeviceName                            = self.etl-text(:TAG<DeviceName>,                           :$!xml) if self.attribute-is-accessed(self.^name, 'DeviceName');
    $!DynamicReconfigurationConnectorName   = self.etl-text(:TAG<DynamicReconfigurationConnectorName>,  :$!xml) if self.attribute-is-accessed(self.^name, 'DynamicReconfigurationConnectorName');
    $!PhysicalLocation                      = self.etl-text(:TAG<PhysicalLocation>,                     :$!xml) if self.attribute-is-accessed(self.^name, 'PhysicalLocation');
    if self.attribute-is-accessed(self.^name, 'PhysicalFibreChannelPorts') {
        my $xml-PhysicalFibreChannelPorts   = self.etl-branch(:TAG<PhysicalFibreChannelPorts>, :$!xml);
        $!PhysicalFibreChannelPorts         = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter::PhysicalFibreChannelPorts.new(:$!config, :xml($xml-PhysicalFibreChannelPorts));
    }
    $!xml                                   = Nil;
    $!initialized                           = True;
    self;
}

=finish
