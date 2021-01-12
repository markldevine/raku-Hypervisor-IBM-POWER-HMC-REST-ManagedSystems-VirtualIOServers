need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::SharedProcessorConfiguration:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked              = False;
my      Bool                                        $analyzed                   = False;
my      Lock                                        $lock                       = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config                    is required;
has     Bool                                        $.initialized               = False;
has     Str                                         $.DesiredProcessingUnits    is conditional-initialization-attribute;
has     Str                                         $.DesiredVirtualProcessors  is conditional-initialization-attribute;
has     Str                                         $.MaximumProcessingUnits    is conditional-initialization-attribute;
has     Str                                         $.MaximumVirtualProcessors  is conditional-initialization-attribute;
has     Str                                         $.MinimumProcessingUnits    is conditional-initialization-attribute;
has     Str                                         $.MinimumVirtualProcessors  is conditional-initialization-attribute;
has     Str                                         $.SharedProcessorPoolID     is conditional-initialization-attribute;
has     Str                                         $.UncappedWeight            is conditional-initialization-attribute;

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
    return self                 if $!initialized;
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!DesiredProcessingUnits    = self.etl-text(:TAG<DesiredProcessingUnits>,   :$!xml) if self.attribute-is-accessed(self.^name, 'DesiredProcessingUnits');
    $!DesiredVirtualProcessors  = self.etl-text(:TAG<DesiredVirtualProcessors>, :$!xml) if self.attribute-is-accessed(self.^name, 'DesiredVirtualProcessors');
    $!MaximumProcessingUnits    = self.etl-text(:TAG<MaximumProcessingUnits>,   :$!xml) if self.attribute-is-accessed(self.^name, 'MaximumProcessingUnits');
    $!MaximumVirtualProcessors  = self.etl-text(:TAG<MaximumVirtualProcessors>, :$!xml) if self.attribute-is-accessed(self.^name, 'MaximumVirtualProcessors');
    $!MinimumProcessingUnits    = self.etl-text(:TAG<MinimumProcessingUnits>,   :$!xml) if self.attribute-is-accessed(self.^name, 'MinimumProcessingUnits');
    $!MinimumVirtualProcessors  = self.etl-text(:TAG<MinimumVirtualProcessors>, :$!xml) if self.attribute-is-accessed(self.^name, 'MinimumVirtualProcessors');
    $!SharedProcessorPoolID     = self.etl-text(:TAG<SharedProcessorPoolID>,    :$!xml) if self.attribute-is-accessed(self.^name, 'SharedProcessorPoolID');
    $!UncappedWeight            = self.etl-text(:TAG<UncappedWeight>,           :$!xml) if self.attribute-is-accessed(self.^name, 'UncappedWeight');
    $!xml                       = Nil;
    $!initialized               = True;
    self;
}

=finish
