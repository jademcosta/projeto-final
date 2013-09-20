# encoding: utf-8

class Publication < Input
   attr_accessible :link, :language, :doi, :bibtex, :status, :title, :text, :subtype

   STATUS_VALUES = ['pesquisa preliminar', 'manuscrito em elaboração', 'manuscrito finalizado', 'submetido (evento/periódico)', 'aceito (evento/periódico)', 'publicado (online)', 'publicado (impresso)']

   SUBTYPE_VALUES = ['artigo completo', 'artigo resumido', 'texto em revista de divulgação científica', 'livro (autor)', 'livro (editor)', 'capítulo de livro', 'apostila', 'tese', 'dissertação', 'relatório técnico']

   validates :status, inclusion: { in: STATUS_VALUES, message: "%{value} não é válido" }
   validates :title, presence: true
   validates :subtype, inclusion: { in: SUBTYPE_VALUES, message: "%{value} não é válido" }
end
