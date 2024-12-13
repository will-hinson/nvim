return {
  'topaxi/pipeline.nvim',
  keys = {
    { '<leader>gi', '<cmd>Pipeline<cr>', desc = 'Open pipeline.nvim' },
  },
  -- optional, you can also install and use `yq` instead.
  build = 'make',
  ---@type pipeline.Config
  opts = {
    highlights = {
      PipelineRunIconSuccess = {link = '_PipelineRunIconSuccess'},
      PipelineRunIconFailure = {link = '_PipelineRunIconFailure'},
      PipelineRunIconStartup_failure = {link = '_PipelineRunIconFailure'},
      PipelineRunIconPending = { link = '_PipelineRunIconPending' },
      PipelineRunIconRequested = { link = '_PipelineRunIconPending' },
      PipelineRunIconWaiting = { link = '_PipelineRunIconPending' },
      PipelineRunIconIn_progress = { link = '_PipelineRunIconPending' },
    }
  },
}
