class Gene
# The gene_information file has 3 columns:
  attr_accessor :gene_ID
  attr_accessor :gene_name
  attr_accessor :mut_phenotype
# Property to be added after the Chi-square test  
  attr_accessor :linked_to
# Class variable that will contain all the genes
# it will allow us to link with Seeds_stock object
  @@all_genes = []
  
  
  def initialize(params = {}) 
    @gene_ID = params.fetch(:gene_ID, "AT0G0000")
    @gene_name = params.fetch(:gene_name, "abc")
    @mut_phenotype = params.fetch(:mut_phenotype, "missing phenotype")
    @linked_to="none"
    @@all_genes << self # save everything in this list
  end
# To create the objects for this class (and the others) I use a class method:
  def Gene.get_genes(file_path)
    File.readlines(file_path)[1..-1].each do |line| #Read the file lines and skip header
      id, name, phenotype = line.strip.split("\t") #strip the lines of newlines' (\n), separate values by tab, and save them in the different instance var 
      if id=~ /A[T]\d[G]\d\d\d\d\d/
        Gene.new(:gene_ID => id  , :gene_name => name,  :mut_phenotype => phenotype)
      else
        puts ("Gene ID: #{id} incorrect")
      end
      
    end
  end
  
  def Gene.get_all # Class method to access all the objects
    return @@all_genes
    
  end
  
  def Gene.get_links #for the final report of linked genes
    Gene.get_all.each do |l|
      if l.linked_to != "none" #if a gene has a link print it
        puts "#{l.gene_name} is linked to #{l.linked_to}"
      end
    end  
  
    
  end
  
    
end